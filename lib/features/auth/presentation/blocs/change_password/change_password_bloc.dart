import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/auth/domain/usecases/change_password_usecase.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc(
    this.authLocalDataSource,
    this.changePasswordUseCase,
  ) : super(ChangePasswordInitial());

  final ChangePasswordUseCase changePasswordUseCase;
  final AuthLocalDataSource authLocalDataSource;

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {
    SessionModel session = await authLocalDataSource.getSession();

    if (event is ChangePassword) {
      yield ChangePasswordLoading();
      Map<String, dynamic> data = {
        "token": session.token,
        "current_password": event.currentPassword,
        "password": event.password,
        "password_confirmation": event.confirmPassword,
      };
      final failOrSuccess = await changePasswordUseCase(data);
      yield* failOrSuccess.fold((fail) async* {
        yield ChangePasswordFailure(failMessage: fail.props.single);
      }, (success) async* {
        yield ChangePasswordSuccess(successMessage: success);
      });
    }
  }
}
