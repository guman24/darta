part of 'get_verification_data_bloc.dart';

abstract class GetVerificationDataEvent extends Equatable {
  const GetVerificationDataEvent();

  @override
  List<Object> get props => [];
}

class GetVerificationUserDataEvent extends GetVerificationDataEvent {}
