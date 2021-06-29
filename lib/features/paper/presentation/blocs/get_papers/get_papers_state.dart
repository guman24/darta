part of 'get_papers_bloc.dart';

abstract class GetPapersState extends Equatable {
  const GetPapersState();

  @override
  List<Object> get props => [];
}

class GetPapersInitial extends GetPapersState {}

class GetPapersLoadingState extends GetPapersState {}

class GetPapersSuccessState extends GetPapersState {
  final List<PaperEntity> papers;

  GetPapersSuccessState({@required this.papers});
}

class GetPapersFailState extends GetPapersState {
  final String errorMessage;
  GetPapersFailState({@required this.errorMessage});
}
