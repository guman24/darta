import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/auth/domain/entities/user_entity.dart';
import 'package:sifaris_app/features/kyc/domain/usecases/get_verification_details_usecase.dart';

part 'verification_user_detail_event.dart';
part 'verification_user_detail_state.dart';

class VerificationUserDetailBloc
    extends Bloc<VerificationUserDetailEvent, VerificationUserDetailState> {
  VerificationUserDetailBloc({
    this.authLocalDataSource,
    this.verificationDetailsUseCase,
  }) : super(VerificationUserDetailInitial());

  final VerificationDetailsUseCase verificationDetailsUseCase;
  final AuthLocalDataSource authLocalDataSource;

  @override
  Stream<VerificationUserDetailState> mapEventToState(
    VerificationUserDetailEvent event,
  ) async* {
    SessionModel sessionModel = await authLocalDataSource.getSession();
    if (event is GetUserVerificationDetailEvent) {
      yield VerificationUserDetailLoading();
      final failOrData = await verificationDetailsUseCase(sessionModel.token);
      yield* failOrData.fold((fail) async* {
        yield VerificationUserDetailFailState(failMessage: fail.props.single);
      }, (data) async* {
        yield VerificationUserDetailLoadedState(userData: data);
      });
    }
  }
}
