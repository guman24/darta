part of 'get_verification_data_bloc.dart';

abstract class GetVerificationDataState extends Equatable {
  const GetVerificationDataState();

  @override
  List<Object> get props => [];
}

class GetVerificationDataInitial extends GetVerificationDataState {}

class GetVerificationDataLoadingState extends GetVerificationDataState {}

class GetVerificationDataSuccessState extends GetVerificationDataState {
  final UserEntity user;
  GetVerificationDataSuccessState({@required this.user});
}

class GetVerificationDataFailState extends GetVerificationDataState {
  final String failMessage;

  GetVerificationDataFailState({@required this.failMessage});
}
