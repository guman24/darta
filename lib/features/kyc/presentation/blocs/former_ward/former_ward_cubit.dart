import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/kyc/domain/entities/former_ward_entity.dart';
import 'package:sifaris_app/features/kyc/domain/usecases/former_ward_usecase.dart';

part 'former_ward_state.dart';

class FormerWardCubit extends Cubit<FormerWardState> {
  FormerWardCubit(this.formerWardUseCase, this.authLocalDataSource)
      : super(FormerWardState(
            formerWards: null, failure: null, loading: true, wards: null));
  final FormerWardUseCase formerWardUseCase;
  final AuthLocalDataSource authLocalDataSource;

  void loadFormerWards() async {
    SessionModel sessionModel = await authLocalDataSource.getSession();

    final failOrFormerWards = await formerWardUseCase(sessionModel.token);

    failOrFormerWards.fold((fail) async* {
      emit(FormerWardState(
          formerWards: null, wards: null, loading: false, failure: fail));
    }, (former) async {
      List<String> wards = former[0].wards;
      print("***heyhey $wards");
      emit(FormerWardState(
          formerWards: former, wards: wards, failure: null, loading: false));
    });
  }

  void changeWards({List<FormerWardEntity> former, String id}) {
    List<String> wards = [];
    former.forEach((element) {
      if (element.id == id) {
        wards = element.wards;
      }
    });
    emit(state.copyWith(wards: wards));
  }
}
