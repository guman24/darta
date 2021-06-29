part of 'auth_cubit.dart';

class AuthState {
  bool showSplash;
  bool authenticated;
  Failure failure;
  AuthState({
    this.showSplash,
    this.authenticated,
    this.failure,
  });
}
