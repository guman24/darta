part of 'notice_bloc.dart';

abstract class NoticeState extends Equatable {
  const NoticeState();

  @override
  List<Object> get props => [];
}

class NoticeInitial extends NoticeState {}

class NoticeLoading extends NoticeState {}

class NoticesLoaded extends NoticeState {
  final List<NoticeEntity> notices;
  NoticesLoaded({
    @required this.notices,
  });
}

class NoticesFailed extends NoticeState {
  final String errorMessage;
  NoticesFailed({
    @required this.errorMessage,
  });
}
