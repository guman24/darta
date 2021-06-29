part of 'profile_edit_bloc.dart';

abstract class ProfileEditState extends Equatable {
  const ProfileEditState();

  @override
  List<Object> get props => [];
}

class ProfileEditInitial extends ProfileEditState {}

class ProfileEmailEdit extends ProfileEditState {
  final String email;
  ProfileEmailEdit({
    @required this.email,
  });
}

class ProfilePhoneEdit extends ProfileEditState {
  final String phone;
  ProfilePhoneEdit({
    @required this.phone,
  });
}

class ProfileWardEdit extends ProfileEditState {
  final String ward;
  ProfileWardEdit({
    @required this.ward,
  });
}

class ProfileGenderEdit extends ProfileEditState {
  final String gender;
  ProfileGenderEdit({
    @required this.gender,
  });
}
