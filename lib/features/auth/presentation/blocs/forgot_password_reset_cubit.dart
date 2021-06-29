import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/injection.dart';

class ForgotPasswordResetCubit extends Cubit<Map<String, dynamic>> {
  ForgotPasswordResetCubit() : super(null);

  final authLocalDataSource = getIt<AuthLocalDataSource>();

  void validatePassword(String password, String confirmPassword) {
    if ((password != null && confirmPassword != null) &&
        password.length >= 6 &&
        password == confirmPassword) {
      authLocalDataSource.saveNewPassword(newPassword: password);
      authLocalDataSource.saveConfirmNewPassword(
          confirmNewPassword: confirmPassword);
      Map<String, dynamic> data = {
        'password': password,
        'confirmPassword': confirmPassword,
      };
      emit(data);
    } else {
      emit(null);
    }
  }
}
