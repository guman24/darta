part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePassword extends ChangePasswordEvent {
  final String currentPassword;
  final String password;
  final String confirmPassword;

  ChangePassword({
    @required this.currentPassword,
    @required this.password,
    @required this.confirmPassword,
  });
}
