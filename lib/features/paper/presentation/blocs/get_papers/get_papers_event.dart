part of 'get_papers_bloc.dart';

abstract class GetPapersEvent extends Equatable {
  const GetPapersEvent();

  @override
  List<Object> get props => [];
}

class PerfomGetPapersEvent extends GetPapersEvent {}
