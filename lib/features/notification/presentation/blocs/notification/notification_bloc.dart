import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/notification/domain/entities/notification_entity.dart';
import 'package:sifaris_app/features/notification/domain/usecases/get_notifications_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(
    this.authLocalDataSource,
    this.getNotificationsUseCase,
  ) : super(NotificationInitial());

  final GetNotificationsUseCase getNotificationsUseCase;
  final AuthLocalDataSource authLocalDataSource;

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    final SessionModel session = await authLocalDataSource.getSession();
    if (event is GetNotificationsEvent) {
      yield NotificationLoadingState();
      final failOrNotifications = await getNotificationsUseCase(session.token);

      yield* failOrNotifications.fold((fail) async* {
        yield NotificationFailedState(errorMessage: fail.props.single);
      }, (notifications) async* {
        yield NotificationLoadedState(notifcations: notifications);
      });
    }
  }
}
