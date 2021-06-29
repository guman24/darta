part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final Map<String, dynamic> response;
  RegisterSuccess({
    @required this.response,
  });
}

class RegisterFail extends RegisterState {
  final Failure failure;

  RegisterFail({@required this.failure});
}

class RegisterVerifyOtpLoading extends RegisterState {}

class RegisterVerifyOtp extends RegisterState {
  final String message;
  RegisterVerifyOtp({
    @required this.message,
  });
}

class RegisterVerifyOtpFail extends RegisterState {
  final Failure failure;
  RegisterVerifyOtpFail({
    @required this.failure,
  });
}
