import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/template/domain/entities/template_category_entity.dart';
import 'package:sifaris_app/features/template/domain/usecases/all_templates_usecase.dart';
import 'package:sifaris_app/features/template/domain/usecases/category_template_usecase.dart';

part 'categorytemplate_event.dart';
part 'categorytemplate_state.dart';

class CategorytemplateBloc
    extends Bloc<CategorytemplateEvent, CategorytemplateState> {
  CategorytemplateBloc({
    this.authLocalDataSource,
    this.categoryTemplateUseCase,
  }) : super(CategorytemplateInitial());
  final AuthLocalDataSource authLocalDataSource;
  final CategoryTemplateUseCase categoryTemplateUseCase;

  @override
  Stream<CategorytemplateState> mapEventToState(
    CategorytemplateEvent event,
  ) async* {
    SessionModel sessionModel = await authLocalDataSource.getSession();

    // !CATERGORICAL TEMPLATES
    if (event is LoadCategoryTemplatesEvent) {
      yield CategoryTemplateLoading();
      final failOrTemplates = await categoryTemplateUseCase(sessionModel.token);

      yield* failOrTemplates.fold((fail) async* {
        yield CategoryTemplatesFailed(errorMessage: fail.props.single);
      }, (templates) async* {
        yield CategoryTemplatesLoaded(categories: templates);
      });
    }
  }
}
