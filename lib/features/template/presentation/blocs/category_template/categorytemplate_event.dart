part of 'categorytemplate_bloc.dart';

abstract class CategorytemplateEvent extends Equatable {
  const CategorytemplateEvent();

  @override
  List<Object> get props => [];
}

class LoadCategoryTemplatesEvent extends CategorytemplateEvent {}
