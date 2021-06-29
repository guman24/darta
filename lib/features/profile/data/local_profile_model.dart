import 'dart:convert';

class LocalProfileModel {
  final String id;
  final String departmentId;
  final String departmentName;
  final String departmentAddress;
  final String organizationId;
  final String orgnaizationName;
  final String organizationAddress;
  final String organizationProvince;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phone;
  final String addressType;
  final String departmentNumber;
  LocalProfileModel({
    this.id,
    this.departmentId,
    this.departmentName,
    this.departmentAddress,
    this.organizationId,
    this.orgnaizationName,
    this.organizationAddress,
    this.organizationProvince,
    this.firstName,
    this.lastName,
    this.middleName,
    this.email,
    this.phone,
    this.addressType,
    this.departmentNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'departmentId': departmentId,
      'departmentName': departmentName,
      'departmentAddress': departmentAddress,
      'organizationId': organizationId,
      'orgnaizationName': orgnaizationName,
      'organizationAddress': organizationAddress,
      'organizationProvince': organizationProvince,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'addressType': addressType,
      'departmentNumber': departmentNumber,
    };
  }

  factory LocalProfileModel.fromMap(Map<String, dynamic> map) {
    return LocalProfileModel(
      id: map['id'],
      departmentId: map['departmentId'],
      departmentName: map['departmentName'],
      departmentAddress: map['departmentAddress'],
      organizationId: map['organizationId'],
      orgnaizationName: map['orgnaizationName'],
      organizationAddress: map['organizationAddress'],
      organizationProvince: map['organizationProvince'],
      firstName: map['firstName'],
      middleName: map['middleName'],
      lastName: map['lastName'],
      email: map['email'],
      phone: map['phone'],
      addressType: map['addressType'],
      departmentNumber: map['departmentNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalProfileModel.fromJson(String source) =>
      LocalProfileModel.fromMap(json.decode(source));
}
