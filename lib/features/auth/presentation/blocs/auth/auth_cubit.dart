import 'package:bloc/bloc.dart';
import 'package:sifaris_app/core/error/exception.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:sifaris_app/features/profile/data/datasources/profile_local_datasource.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.localDataSource, this.refreshTokenUseCase,
      this.profileLocalDataSource)
      : assert(localDataSource != null),
        assert(refreshTokenUseCase != null),
        assert(profileLocalDataSource != null),
        super(AuthState(showSplash: true, authenticated: false, failure: null));
  final AuthLocalDataSource localDataSource;
  final RefreshTokenUseCase refreshTokenUseCase;
  final ProfileLocalDataSource profileLocalDataSource;

  void checkAuthStatus() async {
    await Future.delayed(Duration(seconds: 5));
    try {
      DateTime now = DateTime.now();
      SessionModel session = await localDataSource.getSession();
      if (session != null) {
        DateTime expiry =
            DateTime.fromMicrosecondsSinceEpoch(session.expiry * 1000);
        if (now.isAfter(expiry)) {
          var failOrToken = await refreshTokenUseCase(session.refreshToken);
          failOrToken.fold(
              (fail) => emit(AuthState(
                  showSplash: false,
                  authenticated: false,
                  failure: fail)), (token) {
            session.token = token['token'];
            session.expiry = token['expiry'];
            localDataSource.persistSession(session: session);
            emit(AuthState(
                authenticated: true, showSplash: false, failure: null));
          });
        } else {
          emit(
              AuthState(authenticated: true, showSplash: false, failure: null));
        }
      } else {
        emit(AuthState(showSplash: false, authenticated: false, failure: null));
      }
    } on CacheException {
      print("Failed to cached");
    }
  }

  void loggedIn() =>
      emit(AuthState(showSplash: false, authenticated: true, failure: null));

  void loggedOut() async {
    // clear local data
    await localDataSource.clearSession();
    await profileLocalDataSource.clearProfile();
    emit(AuthState(showSplash: false, authenticated: false, failure: null));
  }
}
