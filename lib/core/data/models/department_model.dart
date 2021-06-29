import 'dart:convert';

import 'package:equatable/equatable.dart';

class DepartmentModel extends Equatable {
  final String id;
  final String name;

  DepartmentModel({
    this.id,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory DepartmentModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DepartmentModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DepartmentModel.fromJson(String source) =>
      DepartmentModel.fromMap(json.decode(source));

  @override
  String toString() => 'Department Entity(id: $id, name: $name)';

  @override
  List<Object> get props => [id, name];
}
