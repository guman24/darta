import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/auth/domain/entities/user_entity.dart';
import 'package:sifaris_app/features/kyc/domain/usecases/get_verification_details_usecase.dart';

part 'get_verification_data_event.dart';
part 'get_verification_data_state.dart';

class GetVerificationDataBloc
    extends Bloc<GetVerificationDataEvent, GetVerificationDataState> {
  GetVerificationDataBloc(
    this.authLocalDataSource,
    this.verificationDetailsUseCase,
  ) : super(GetVerificationDataInitial());
  final VerificationDetailsUseCase verificationDetailsUseCase;
  final AuthLocalDataSource authLocalDataSource;

  @override
  Stream<GetVerificationDataState> mapEventToState(
    GetVerificationDataEvent event,
  ) async* {
    SessionModel sessionModel = await authLocalDataSource.getSession();
    if (event is GetVerificationUserDataEvent) {
      yield GetVerificationDataLoadingState();
      final failOrData = await verificationDetailsUseCase(sessionModel.token);
      yield* failOrData.fold((fail) async* {
        yield GetVerificationDataFailState(failMessage: fail.props.single);
      }, (data) async* {
        yield GetVerificationDataSuccessState(user: data);
      });
    }
  }
}
