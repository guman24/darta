part of 'papercreate_bloc.dart';

abstract class PaperCreateEvent extends Equatable {
  const PaperCreateEvent();

  @override
  List<Object> get props => [];
}

class PaperCreateRequestEvent extends PaperCreateEvent {
  final Map<String, dynamic> data;
  final Map<String, dynamic> newAttributes;
  final List<DocumentEntity> documents;
  PaperCreateRequestEvent({
    this.data,
    this.newAttributes,
    this.documents,
  });
  @override
  List<Object> get props => [data, newAttributes, documents];
}
