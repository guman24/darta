import 'dart:convert';

import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final int createdAt;
  final String body;
  final String title;
  final String type;
  final String status;

  NotificationEntity({
    this.id,
    this.createdAt,
    this.title,
    this.body,
    this.type,
    this.status,
  });

  factory NotificationEntity.fromMap(Map<String, dynamic> map) {
    return NotificationEntity(
      id: map['id'],
      createdAt: map['created_at'],
      title: map['title'],
      body: map['body'],
      type: map['type'],
      status: map['status'],
    );
  }

  factory NotificationEntity.fromJson(String source) =>
      NotificationEntity.fromMap(json.decode(source));

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
