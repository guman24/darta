import 'dart:convert';

import 'package:equatable/equatable.dart';

class DocumentEntity extends Equatable {
  String title;
  String url;

  DocumentEntity({
    this.title,
    this.url,
  });

  DocumentEntity copyWith({
    String title,
    String url,
  }) {
    return DocumentEntity(
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
    };
  }

  factory DocumentEntity.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DocumentEntity(
      title: map['title'],
      url: map['file_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentEntity.fromJson(String source) =>
      DocumentEntity.fromMap(json.decode(source));

  @override
  String toString() => 'File Document(title: $title, url: $url)';

  @override
  List<Object> get props => [title, url];
}
