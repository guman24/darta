import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/paper/domain/entities/paper_entity.dart';
import 'package:sifaris_app/features/paper/domain/repositories/paper_repository.dart';
import 'package:sifaris_app/features/paper/domain/usecases/get_paper_usecase.dart';
import 'package:sifaris_app/features/paper/presentation/blocs/paper_create/papercreate_bloc.dart';

part 'get_papers_event.dart';
part 'get_papers_state.dart';

class GetPapersBloc extends Bloc<GetPapersEvent, GetPapersState> {
  GetPapersBloc(
    this.paperRepository,
    this.authLocalDataSource,
    this.getPapersUseCase,
  ) : super(GetPapersInitial());
  final AuthLocalDataSource authLocalDataSource;
  final PaperRepository paperRepository;
  final GetPapersUseCase getPapersUseCase;

  @override
  Stream<GetPapersState> mapEventToState(
    GetPapersEvent event,
  ) async* {
    SessionModel sessionModel = await authLocalDataSource.getSession();
    if (event is PerfomGetPapersEvent) {
      yield GetPapersLoadingState();
      final failOrPapers = await getPapersUseCase(sessionModel.token);

      yield* failOrPapers.fold((fail) async* {
        yield GetPapersFailState(errorMessage: fail.props.single);
      }, (papers) async* {
        yield GetPapersSuccessState(papers: papers);
      });
    }
  }
}
