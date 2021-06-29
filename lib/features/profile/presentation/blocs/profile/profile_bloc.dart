import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/profile/domain/entities/profile_entity.dart';
import 'package:sifaris_app/features/profile/domain/usecases/get_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    @required this.authLocalDataSource,
    @required this.getProfileUseCase,
  }) : super(ProfileInitial());

  final AuthLocalDataSource authLocalDataSource;
  final GetProfileUseCase getProfileUseCase;

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    final SessionModel session = await authLocalDataSource.getSession();
    if (event is GetProfileEvent) {
      yield ProfileLoadingState();
      final failOrProfile = await getProfileUseCase(session.token);

      yield* failOrProfile.fold((fail) async* {
        yield ProfileLoadFailState(errorMessage: fail.props.single);
      }, (profile) async* {
        yield ProfileLoadedState(profile: profile);
      });
    }
  }
}
