import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/notice/domain/entities/notice_entity.dart';
import 'package:sifaris_app/features/notice/domain/usecases/get_notice_usecase.dart';

part 'notice_event.dart';
part 'notice_state.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  NoticeBloc(this.noticeUseCase, this.authLocalDataSource)
      : assert(noticeUseCase != null),
        assert(authLocalDataSource != null),
        super(NoticeInitial());

  final GetNoticeUseCase noticeUseCase;
  final AuthLocalDataSource authLocalDataSource;

  @override
  Stream<NoticeState> mapEventToState(
    NoticeEvent event,
  ) async* {
    SessionModel session = await authLocalDataSource.getSession();
    if (event is GetNoticesEvent) {
      yield NoticeLoading();
      final failOrNotices = await noticeUseCase(session.token);
      yield* failOrNotices.fold((fail) async* {
        yield NoticesFailed(errorMessage: fail.props.single);
      }, (notices) async* {
        yield NoticesLoaded(notices: notices);
      });
    }
  }
}
