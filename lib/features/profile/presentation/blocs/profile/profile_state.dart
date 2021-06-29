part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final ProfileEntity profile;

  ProfileLoadedState({@required this.profile});
}

class ProfileLoadFailState extends ProfileState {
  final String errorMessage;

  ProfileLoadFailState({@required this.errorMessage});
}
