import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NoticeEntity extends Equatable {
  final String id;
  final String createdAt;
  final String title;
  final String description;
  final String createdBy;
  final String fileURL;
  NoticeEntity({
    @required this.id,
    @required this.createdAt,
    @required this.title,
    @required this.createdBy,
    @required this.fileURL,
    @required this.description,
  });

  @override
  List<Object> get props => null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'title': title,
      'createdBy': createdBy,
      'fileURL': fileURL,
      'description': description,
    };
  }

  factory NoticeEntity.fromMap(Map<String, dynamic> map) {
    return NoticeEntity(
        id: map['id'],
        createdAt: map['created_at'],
        title: map['title'],
        createdBy: map['created_by'],
        fileURL: map['file_url'],
        description: map['description']);
  }

  String toJson() => json.encode(toMap());

  factory NoticeEntity.fromJson(String source) =>
      NoticeEntity.fromMap(json.decode(source));

  NoticeEntity copyWith({
    String id,
    String createdAt,
    String title,
    String createdBy,
    String fileURL,
  }) {
    return NoticeEntity(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      createdBy: createdBy ?? this.createdBy,
      fileURL: fileURL ?? this.fileURL,
      description: description ?? this.description,
    );
  }
}
