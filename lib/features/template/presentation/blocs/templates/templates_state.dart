part of 'templates_bloc.dart';

abstract class TemplatesState extends Equatable {
  const TemplatesState();

  @override
  List<Object> get props => [];
}

class TemplatesInitial extends TemplatesState {}

class TemplatesLoading extends TemplatesState {}

class TemplatesSearchLoading extends TemplatesState {}

class CategoryTemplatesInitial extends TemplatesState {}

class TemplatesLoaded extends TemplatesState {
  final List<TemplateEntity> templates;
  TemplatesLoaded({
    @required this.templates,
  });
}

class TemplatesFailed extends TemplatesState {
  final String errorMessage;
  TemplatesFailed({
    @required this.errorMessage,
  });
}
