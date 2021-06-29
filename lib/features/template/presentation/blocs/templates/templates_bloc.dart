import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/template/domain/entities/template_entity.dart';
import 'package:sifaris_app/features/template/domain/usecases/all_templates_usecase.dart';
import 'package:sifaris_app/features/template/domain/usecases/popular_templates_usecase.dart';

part 'templates_event.dart';
part 'templates_state.dart';

class TemplatesBloc extends Bloc<TemplatesEvent, TemplatesState> {
  TemplatesBloc(this.getTemplatesUseCase, this.authLocalDataSource,
      this.popularTemplatesUseCase)
      : assert(getTemplatesUseCase != null),
        assert(authLocalDataSource != null),
        assert(popularTemplatesUseCase != null),
        super(TemplatesInitial());

  final AllTemplatesUseCase getTemplatesUseCase;
  final AuthLocalDataSource authLocalDataSource;
  final PopularTemplatesUseCase popularTemplatesUseCase;

  @override
  Stream<TemplatesState> mapEventToState(
    TemplatesEvent event,
  ) async* {
    SessionModel sessionModel = await authLocalDataSource.getSession();

    // !ALL TEMPLATES
    if (event is LoadAllTemplatesEvent) {
      yield TemplatesLoading();
      final failOrTemplates = await getTemplatesUseCase(sessionModel.token);
      yield* failOrTemplates.fold((fail) async* {
        yield TemplatesFailed(errorMessage: fail.props.single);
      }, (templates) async* {
        yield TemplatesLoaded(templates: templates);
      });
    }

    // ! POPULAR TEMPLATES
    if (event is LoadPopularTemplates) {
      yield TemplatesLoading();
      final failOrTemplates = await popularTemplatesUseCase(sessionModel.token);
      yield* failOrTemplates.fold((fail) async* {
        yield TemplatesFailed(errorMessage: fail.props.single);
      }, (templates) async* {
        yield TemplatesLoaded(templates: templates);
      });
    }

    // !SEARCH TEMPLATES
    if (event is SearchTemplatesEvent) {
      print("***event ${event.keyword}");

      if (state is TemplatesLoaded) {
        print("**st $state");
        final currentState = state as TemplatesLoaded;
        List<TemplateEntity> templates = currentState.templates
            .where((template) => template.title.contains(event.keyword))
            .toList();
        print("***${templates.length}");

        // print("temps ${currentState.templates}");

        yield TemplatesLoaded(templates: templates);
      }
    }
  }
}
