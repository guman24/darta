import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'profile_toggle_state.dart';

class ProfileToggleCubit extends Cubit<ProfileToggleState> {
  ProfileToggleCubit() : super(ProfileToggleState(isEdit: false, isView: true));

  void toggle({bool isEdidt}) {
    if (isEdidt)
      emit(ProfileToggleState(isEdit: true, isView: false));
    else
      emit(ProfileToggleState(isEdit: false, isView: true));
  }
}
