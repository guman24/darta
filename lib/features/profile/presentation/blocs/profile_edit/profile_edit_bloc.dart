import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc() : super(ProfileEditInitial());

  @override
  Stream<ProfileEditState> mapEventToState(
    ProfileEditEvent event,
  ) async* {
    if (event is ProfileEmailEditEvent) {
      yield ProfileEmailEdit(email: event.value);
    }
    if (event is ProfilePhoneEditEvent) {
      yield ProfilePhoneEdit(phone: event.value);
    }
    if (event is ProfileGenderEditEvent) {
      yield ProfileGenderEdit(gender: event.value);
    }
    if (event is ProfileWardEditEvent) {
      yield ProfileWardEdit(ward: event.value);
    }
  }
}
