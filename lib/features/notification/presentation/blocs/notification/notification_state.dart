part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationLoadedState extends NotificationState {
  final List<NotificationEntity> notifcations;

  NotificationLoadedState({@required this.notifcations});
}

class NotificationFailedState extends NotificationState {
  final String errorMessage;

  NotificationFailedState({@required this.errorMessage});
}
