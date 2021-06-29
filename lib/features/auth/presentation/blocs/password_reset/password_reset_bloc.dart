import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sifaris_app/features/auth/domain/usecases/password_reset_sent_otp_usecase.dart';
import 'package:sifaris_app/features/auth/domain/usecases/password_reset_usecase.dart';

part 'password_reset_event.dart';
part 'password_reset_state.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  PasswordResetBloc(
    this.sentOtpUseCase,
    this.passwordResetUseCase,
  ) : super(PasswordResetInitial());

  final PasswordResetSentOtpUseCase sentOtpUseCase;
  final PasswordResetUseCase passwordResetUseCase;
  @override
  Stream<PasswordResetState> mapEventToState(
    PasswordResetEvent event,
  ) async* {
    if (event is ResetSendOtp) {
      yield PasswordResetSendOtpLoading();
      final failOrOtp = await sentOtpUseCase(event.email);
      yield* failOrOtp.fold((fail) async* {
        yield PasswordResetFailure(failMessage: fail.props.single);
      }, (otp) async* {
        yield PasswordResetSentOtp(
          messege: otp['message'],
          otp: otp['otp'],
        );
      });
    } else if (event is ResetPassword) {
      yield PasswrodResetLoading();
      Map<String, dynamic> data = {
        "email": event.email,
        "otp": event.otp,
        "password": event.password,
        "password_confirmation": event.confirmPassword,
      };
      print("bloc data $data");
      final failOrSuccess = await passwordResetUseCase(data);
      yield* failOrSuccess.fold((fail) async* {
        yield PasswordResetFailure(failMessage: fail.props.single);
      }, (success) async* {
        yield PasswordResetSuccess(successMessage: success);
      });
    }
  }
}
