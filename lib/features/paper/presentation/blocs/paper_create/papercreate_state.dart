part of 'papercreate_bloc.dart';

abstract class PaperCreateState extends Equatable {
  const PaperCreateState();

  @override
  List<Object> get props => [];
}

class PapercreateInitial extends PaperCreateState {}

class PaperUserDetailLoadingState extends PaperCreateState {}

class PaperGetUserDetailState extends PaperCreateState {
  final UserEntity profile;

  PaperGetUserDetailState({this.profile});

  @override
  List<Object> get props => [profile];
}

class PaperCreateProfileFailedState extends PaperCreateState {
  final String errorMessage;
  PaperCreateProfileFailedState({
    @required this.errorMessage,
  });
  List<Object> get props => [errorMessage];
}

class PaperRequstLoading extends PaperCreateState {}

class PaperCreateRequestSuccess extends PaperCreateState {
  final String successMessage;
  PaperCreateRequestSuccess({
    @required this.successMessage,
  });
}

class PaperCreateRequestFail extends PaperCreateState {
  final String failMessage;
  PaperCreateRequestFail({
    @required this.failMessage,
  });
}
