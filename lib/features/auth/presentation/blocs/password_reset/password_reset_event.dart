part of 'password_reset_bloc.dart';

abstract class PasswordResetEvent extends Equatable {
  const PasswordResetEvent();

  @override
  List<Object> get props => [];
}

class ResetSendOtp extends PasswordResetEvent {
  final String email;

  ResetSendOtp({@required this.email});
}

class ResetPassword extends PasswordResetEvent {
  final String otp;
  final String email;
  final String password;
  final String confirmPassword;

  ResetPassword({
    @required this.otp,
    @required this.email,
    @required this.password,
    @required this.confirmPassword,
  });
}
