import 'dart:convert';

import 'package:sifaris_app/core/data/models/department_model.dart';
import 'package:sifaris_app/core/domain/entities/organization_entity.dart';

class OrganizationModel extends OrganizationEntity {
  final String organizationName;
  final String id;
  final List<String> individualDocuments;
  final List<DepartmentModel> departments;
  OrganizationModel({
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
      'departments': departments?.map((x) => x.toMap())?.toList(),
    };
  }

  factory OrganizationModel.fromMap(Map<String, dynamic> map) {
    return OrganizationModel(
      organizationName: map['name'],
      id: map['id'],
      individualDocuments: List<String>.from(map['individual_documents']),
      departments: List<DepartmentModel>.from(
          map['departments']?.map((x) => DepartmentModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrganizationModel.fromJson(String source) =>
      OrganizationModel.fromMap(json.decode(source));
}
