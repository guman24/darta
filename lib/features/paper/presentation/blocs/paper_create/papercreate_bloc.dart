import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sifaris_app/core/domain/entities/document_entity.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/auth/domain/entities/user_entity.dart';
import 'package:sifaris_app/features/kyc/domain/usecases/get_verification_details_usecase.dart';
import 'package:sifaris_app/features/paper/domain/usecases/paper_request_usecase.dart';
import 'package:sifaris_app/features/profile/domain/entities/profile_entity.dart';
import 'package:sifaris_app/features/profile/domain/repositories/profile_repository.dart';

part 'papercreate_event.dart';
part 'papercreate_state.dart';

class PaperCreateBloc extends Bloc<PaperCreateEvent, PaperCreateState> {
  PaperCreateBloc(
    this.authLocalDataSource,
    this.profileRepository,
    this.verificationDetailsUseCase,
    this.paperRequestUseCase,
  )   : assert(authLocalDataSource != null),
        assert(profileRepository != null),
        assert(verificationDetailsUseCase != null),
        assert(paperRequestUseCase != null),
        super(PapercreateInitial());

  final AuthLocalDataSource authLocalDataSource;
  final ProfileRepository profileRepository;
  final VerificationDetailsUseCase verificationDetailsUseCase;
  final PaperRequestUseCase paperRequestUseCase;
  @override
  Stream<PaperCreateState> mapEventToState(
    PaperCreateEvent event,
  ) async* {
    SessionModel sessionModel = await authLocalDataSource.getSession();

    // if (event is PaperCreateGetProfileEvent) {
    //   yield PaperUserDetailLoadingState();
    //   final failOrData = await verificationDetailsUseCase(sessionModel.token);
    //   yield* failOrData.fold((fail) async* {
    //     yield PaperCreateProfileFailedState(errorMessage: fail.props.single);
    //   }, (data) async* {
    //     yield PaperGetUserDetailState(profile: data);
    //   });
    // }
    if (event is PaperCreateRequestEvent) {
      yield PaperRequstLoading();
      final failOrSuccess = await paperRequestUseCase(PaperRequstParams(
          data: event.data,
          documents: event.documents,
          token: sessionModel.token,
          newAttributes: event.newAttributes));
      yield* failOrSuccess.fold((fail) async* {
        yield PaperCreateRequestFail(failMessage: fail.props.single);
      }, (succes) async* {
        yield PaperCreateRequestSuccess(successMessage: succes);
      });
    }
  }
}
