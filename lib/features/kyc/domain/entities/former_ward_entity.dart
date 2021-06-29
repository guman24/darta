import 'dart:convert';

import 'package:flutter/material.dart';

class FormerWardEntity {
  final String id;
  final String title;
  final List<String> wards;
  FormerWardEntity({
    @required this.id,
    @required this.title,
    @required this.wards,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'wards': wards,
    };
  }

  factory FormerWardEntity.fromMap(Map<String, dynamic> map) {
    return FormerWardEntity(
      id: map['id'],
      title: map['title'],
      wards: List<String>.from(map['former_wards']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FormerWardEntity.fromJson(String source) =>
      FormerWardEntity.fromMap(json.decode(source));
}
