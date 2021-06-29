part of 'categorytemplate_bloc.dart';

abstract class CategorytemplateState extends Equatable {
  const CategorytemplateState();

  @override
  List<Object> get props => [];
}

class CategorytemplateInitial extends CategorytemplateState {}

class CategoryTemplateLoading extends CategorytemplateState {}

class CategoryTemplatesLoaded extends CategorytemplateState {
  final List<TemplateCategoryEntity> categories;

  CategoryTemplatesLoaded({@required this.categories});
}

class CategoryTemplatesFailed extends CategorytemplateState {
  final String errorMessage;
  CategoryTemplatesFailed({
    @required this.errorMessage,
  });
}
