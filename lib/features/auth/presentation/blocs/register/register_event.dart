part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class PerformRegister extends RegisterEvent {
  final Map<String, dynamic> formData;
  PerformRegister({
    @required this.formData,
  });
}

class PerformOtpVerification extends RegisterEvent {
  final Map<String, dynamic> verifyData;
  PerformOtpVerification({
    @required this.verifyData,
  });
}
