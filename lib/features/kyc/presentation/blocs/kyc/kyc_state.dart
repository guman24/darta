part of 'kyc_bloc.dart';

abstract class KycState extends Equatable {
  const KycState();

  @override
  List<Object> get props => [];
}

class KycInitial extends KycState {}

class KycVerifyLoading extends KycState {}

class KycSuccess extends KycState {
  final String message;

  KycSuccess({@required this.message});
}

class KycFailure extends KycState {
  final String failMessage;
  KycFailure({
    @required this.failMessage,
  });
}
