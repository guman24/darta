import 'dart:convert';

import 'package:sifaris_app/core/domain/entities/document_entity.dart';

class ProfileModel {
  String id;
  String email;
  String firstName;
  String lastName;
  String status;
  String phone;
  String otpCode;
  CitizenDetail citizenDetails;
  List<DocumentEntity> personalDocuments;
  ProfileModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.status,
    this.phone,
    this.otpCode,
    this.citizenDetails,
    this.personalDocuments,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'status': status,
      'phone': phone,
      'otpCode': otpCode,
      'citizenDetails': citizenDetails.toMap(),
      'personalDocuments': personalDocuments?.map((x) => x.toMap())?.toList(),
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'],
      email: map['email'],
      firstName: map['first_name'],
      lastName: map['last_lame'],
      status: map['status'],
      phone: map['phone'],
      otpCode: map['otp_code'],
      citizenDetails: CitizenDetail.fromMap(map['citizen_details']),
      personalDocuments: List<DocumentEntity>.from(
          map['personal_documents']?.map((x) => DocumentEntity.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source));
}

class CitizenDetail {
  String id;
  String citizenshipNumber;
  String citizenshipIssueDistrict;
  String applicantName;
  String birthDate;
  String applicantPhone;
  String fatherName;
  String motherName;
  String temporaryProvince;
  String temporaryDistrict;
  String temporaryMunicipality;
  String temporaryWard;
  String permanentProvince;
  String permanentDistrict;
  String permanentMunicipality;
  String permanentWard;
  String formerMunicipality;
  String formerWard;
  bool verified;
  CitizenDetail({
    this.id,
    this.citizenshipNumber,
    this.citizenshipIssueDistrict,
    this.applicantName,
    this.birthDate,
    this.applicantPhone,
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
    this.formerMunicipality = "",
    this.formerWard = "",
    this.verified,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'citizenship_number': citizenshipNumber,
      'citizenship_issue_district': citizenshipIssueDistrict,
      'applicant_name': applicantName,
      'dob': birthDate,
      'applicant_phone': applicantPhone,
      'father_name': fatherName,
      'mother_name': motherName,
      'temporary_province': temporaryProvince,
      'temporary_district': temporaryDistrict,
      'temporary_municipality': temporaryMunicipality,
      'temporary_ward': temporaryWard,
      'permanent_province': permanentProvince,
      'permanent_district': permanentDistrict,
      'permanent_municipality': permanentMunicipality,
      'permanent_ward': permanentWard,
      'former_municipality': formerMunicipality ?? "Galkot",
      'former_ward': formerWard ?? "2",
    };
  }

  factory CitizenDetail.fromMap(Map<String, dynamic> map) {
    return CitizenDetail(
      id: map['id'],
      citizenshipNumber: map['citizenship_number'],
      citizenshipIssueDistrict: map['citizenship_issue_district'],
      applicantName: map['applicant_name'],
      birthDate: map['dob'],
      applicantPhone: map['applicant_phone'],
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
      formerMunicipality: map['former_municipality_vdc'],
      formerWard: map['former_ward'],
      verified: map['verified'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CitizenDetail.fromJson(String source) =>
      CitizenDetail.fromMap(json.decode(source));
}
