part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PerformLogin extends LoginEvent {
  final Map<String, dynamic> data;

  PerformLogin({@required this.data});
}
