import 'dart:convert';

import 'package:sifaris_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String message;
  final String id;
  final String citizenshipNumber;
  final String citizenshipIssueDistrict;
  final String applicantName;
  final String applicantPhone;
  final String birthDate;
  final String fatherName;
  final String motherName;
  final String temporaryProvince;
  final String temporaryDistrict;
  final String temporaryMunicipality;
  final String temporaryWard;
  final String permanentProvince;
  final String permanentDistrict;
  final String permanentMunicipality;
  final String permanentWard;
  final String formerMunicipality;
  final String formerWard;
  final bool verified;

  UserModel({
    this.message,
    this.id,
    this.citizenshipNumber,
    this.citizenshipIssueDistrict,
    this.applicantName,
    this.applicantPhone,
    this.birthDate,
    this.fatherName,
    this.motherName,
    this.temporaryProvince,
    this.temporaryDistrict,
    this.temporaryMunicipality,
    this.temporaryWard,
    this.permanentProvince,
    this.permanentDistrict,
    this.permanentMunicipality,
    this.permanentWard,
    this.formerMunicipality,
    this.formerWard,
    this.verified,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'id': id,
      'citizenshipNumber': citizenshipNumber,
      'citizenshipIssueDistrict': citizenshipIssueDistrict,
      'applicantName': applicantName,
      'applicantPhone': applicantPhone,
      'birthDate': birthDate,
      'fatherName': fatherName,
      'motherName': motherName,
      'temporaryProvince': temporaryProvince,
      'temporaryDistrict': temporaryDistrict,
      'temporaryMunicipality': temporaryMunicipality,
      'temporaryWard': temporaryWard,
      'permanentProvince': permanentProvince,
      'permanentDistrict': permanentDistrict,
      'permanentMunicipality': permanentMunicipality,
      'permanentWard': permanentWard,
      'formerMunicipality': formerMunicipality,
      'formerWard': formerWard,
      'verified': verified,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      message: map['message'],
      id: map['id'],
      citizenshipNumber: map['citizenship_number'],
      citizenshipIssueDistrict: map['citizenship_issue_district'],
      applicantName: map['applicant_name'],
      applicantPhone: map['applicant_phone'],
      birthDate: map['dob'],
      fatherName: map['father_name'],
      motherName: map['mother_name'],
      temporaryProvince: map['temporary_province'],
      temporaryDistrict: map['temporary_district'],
      temporaryMunicipality: map['temporary_municipality'],
      temporaryWard: map['temporary_ward'],
      permanentProvince: map['permanent_province'],
      permanentDistrict: map['permanent_district'],
      permanentMunicipality: map['permanent_municipality'],
      permanentWard: map['permanent_ward'],
      formerMunicipality: map['former_municipality'],
      formerWard: map['former_ward'],
      verified: map['verified'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
