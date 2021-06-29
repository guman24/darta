part of 'password_reset_bloc.dart';

abstract class PasswordResetState extends Equatable {
  const PasswordResetState();

  @override
  List<Object> get props => [];
}

class PasswordResetInitial extends PasswordResetState {}

class PasswordResetSendOtpLoading extends PasswordResetState {}

class PasswrodResetLoading extends PasswordResetState {}

class PasswordResetSentOtp extends PasswordResetState {
  final String messege;
  final String otp;

  PasswordResetSentOtp({
    @required this.messege,
    @required this.otp,
  });
}

class PasswordResetSuccess extends PasswordResetState {
  final String successMessage;

  PasswordResetSuccess({@required this.successMessage});
}

class PasswordResetFailure extends PasswordResetState {
  final String failMessage;

  PasswordResetFailure({@required this.failMessage});
}
