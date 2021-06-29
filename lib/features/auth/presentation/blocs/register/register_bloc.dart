import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/features/auth/domain/usecases/otp_verify_usecase.dart';
import 'package:sifaris_app/features/auth/domain/usecases/signup_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({@required this.signupUseCase, @required this.otpVerifyUseCase})
      : assert(signupUseCase != null),
        assert(otpVerifyUseCase != null),
        super(RegisterInitial());

  final SignupUseCase signupUseCase;
  final OtpVerifyUseCase otpVerifyUseCase;

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is PerformRegister) {
      yield RegisterLoading();

      final failOrRegister = await signupUseCase(SignUpParams(
          email: event.formData['email'],
          password: event.formData['password'],
          firstName: event.formData['first_name'],
          lastName: event.formData['last_name'],
          citizenshipNumber: event.formData['citizenship_number'],
          organizationId: event.formData['organization_id'],
          departmentId: event.formData['department_id'],
          phone: event.formData['phone'],
          gender: event.formData['gender'],
          addressType: event.formData['address_type']));
      print("register bloc $failOrRegister");
      yield* failOrRegister.fold((fail) async* {
        yield RegisterFail(failure: fail);
      }, (response) async* {
        yield RegisterSuccess(response: response);
      });
    }

    if (event is PerformOtpVerification) {
      print("test");
      yield RegisterVerifyOtpLoading();
      final failOrVerify = await otpVerifyUseCase(VerifyParams(
        otp: event.verifyData['otp'],
        userId: event.verifyData['user_id'],
      ));
      yield* failOrVerify.fold((fail) async* {
        yield RegisterVerifyOtpFail(failure: fail);
      }, (message) async* {
        yield RegisterVerifyOtp(message: message['message']);
      });
    }
  }
}
