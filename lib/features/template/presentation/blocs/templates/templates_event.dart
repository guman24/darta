part of 'templates_bloc.dart';

abstract class TemplatesEvent extends Equatable {
  const TemplatesEvent();

  @override
  List<Object> get props => [];
}

class LoadAllTemplatesEvent extends TemplatesEvent {}

class LoadPopularTemplates extends TemplatesEvent {}

class SearchTemplatesEvent extends TemplatesEvent {
  final String keyword;
  SearchTemplatesEvent({
    @required this.keyword,
  });
}
