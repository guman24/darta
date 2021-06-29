import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:sifaris_app/core/data/models/department_model.dart';

class OrganizationEntity extends Equatable {
  final String organizationName;
  final String id;
  final List<String> individualDocuments;
  final List<DepartmentModel> departments;

  OrganizationEntity({
    this.organizationName,
    this.id,
    this.individualDocuments,
    this.departments,
  });

  Map<String, dynamic> toMap() {
    return {
      'organizationName': organizationName,
      'id': id,
      'individualDocuments': individualDocuments,
      'departments': departments?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory OrganizationEntity.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return OrganizationEntity(
      organizationName: map['name'],
      id: map['id'],
      individualDocuments: List<String>.from(map['individual_documents']),
      departments: List<DepartmentModel>.from(
          map['departments']?.map((x) => DepartmentModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrganizationEntity.fromJson(String source) =>
      OrganizationEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Organization(organizationName: $organizationName, id: $id, individualDocuments: $individualDocuments, departments: $departments)';
  }

  @override
  List<Object> get props =>
      [id, organizationName, individualDocuments, departments];
}
