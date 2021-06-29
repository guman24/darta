import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sifaris_app/core/constants/enums.dart';
import 'package:sifaris_app/core/domain/entities/document_entity.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/auth/domain/entities/user_entity.dart';
import 'package:sifaris_app/features/kyc/domain/usecases/get_verification_details_usecase.dart';
import 'package:sifaris_app/features/kyc/domain/usecases/user_verify_usecase.dart';
import 'package:sifaris_app/features/profile/data/datasources/profile_local_datasource.dart';

part 'kyc_event.dart';
part 'kyc_state.dart';

class KycBloc extends Bloc<KycEvent, KycState> {
  KycBloc(
    this.userVerifyUseCase,
    this.authLocalDataSource,
    this.profileLocalDataSource,
  )   : assert(userVerifyUseCase != null),
        assert(authLocalDataSource != null),
        assert(profileLocalDataSource != null),
        super(KycInitial());

  final UserVerifyUseCase userVerifyUseCase;
  final AuthLocalDataSource authLocalDataSource;
  final ProfileLocalDataSource profileLocalDataSource;

  @override
  Stream<KycState> mapEventToState(
    KycEvent event,
  ) async* {
    SessionModel sessionModel = await authLocalDataSource.getSession();
    if (event is PerformKycVerification) {
      yield KycVerifyLoading();
      final failOrVerify = await userVerifyUseCase(UserVerifyParams(
          data: event.data,
          token: sessionModel.token,
          files: event.files,
          userPhotoURL: event.userPhotoUrl));
      yield* failOrVerify.fold((fail) async* {
        yield KycFailure(failMessage: _mapFailureToStream(fail));
      }, (message) async* {
        await authLocalDataSource.updateStatus(
            status: VerificationEnum.Sent.toString());
        yield KycSuccess(message: message);
      });
    }
  }

  String _mapFailureToStream(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.props.single;
        break;
      default:
        return "Unexpected Error";
    }
  }
}
