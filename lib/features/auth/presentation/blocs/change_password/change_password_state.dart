part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordFailure extends ChangePasswordState {
  final String failMessage;

  ChangePasswordFailure({@required this.failMessage});
}

class ChangePasswordSuccess extends ChangePasswordState {
  final String successMessage;

  ChangePasswordSuccess({@required this.successMessage});
}
