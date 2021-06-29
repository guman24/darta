part of 'verification_user_detail_bloc.dart';

abstract class VerificationUserDetailEvent extends Equatable {
  const VerificationUserDetailEvent();

  @override
  List<Object> get props => [];
}

class GetUserVerificationDetailEvent extends VerificationUserDetailEvent {}
