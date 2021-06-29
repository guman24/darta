part of 'profile_edit_bloc.dart';

abstract class ProfileEditEvent extends Equatable {
  const ProfileEditEvent();

  @override
  List<Object> get props => [];
}

class ProfileEmailEditEvent extends ProfileEditEvent {
  final String value;
  ProfileEmailEditEvent({
    @required this.value,
  });
}

class ProfilePhoneEditEvent extends ProfileEditEvent {
  final String value;
  ProfilePhoneEditEvent({
    @required this.value,
  });
}

class ProfileGenderEditEvent extends ProfileEditEvent {
  final String value;
  ProfileGenderEditEvent({
    @required this.value,
  });
}

class ProfileWardEditEvent extends ProfileEditEvent {
  final String value;
  ProfileWardEditEvent({
    @required this.value,
  });
}
