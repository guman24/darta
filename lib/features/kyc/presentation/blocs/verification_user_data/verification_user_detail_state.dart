part of 'verification_user_detail_bloc.dart';

abstract class VerificationUserDetailState extends Equatable {
  const VerificationUserDetailState();

  @override
  List<Object> get props => [];
}

class VerificationUserDetailInitial extends VerificationUserDetailState {}

class VerificationUserDetailLoading extends VerificationUserDetailState {}

class VerificationUserDetailLoadedState extends VerificationUserDetailState {
  final UserEntity userData;
  VerificationUserDetailLoadedState({@required this.userData});
}

class VerificationUserDetailFailState extends VerificationUserDetailState {
  final String failMessage;

  VerificationUserDetailFailState({@required this.failMessage});
}
