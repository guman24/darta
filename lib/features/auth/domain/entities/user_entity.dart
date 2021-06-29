import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:sifaris_app/core/domain/entities/document_entity.dart';

class UserEntity extends Equatable {
  final String message;
  final String id;
  final String citizenshipNumber;
  final String citizenshipIssueDistrict;
  final String firstName;
  final String lastName;
  final String middleName;
  final String photoURL;
  final String applicantPhone;
  final String birthDate;
  final String fatherName;
  final String motherName;
  final String spouseName;
  final String temporaryProvince;
  final String temporaryDistrict;
  final String temporaryMunicipality;
  final String temporaryWard;
  final String permanentProvince;
  final String permanentDistrict;
  final String permanentMunicipality;
  final String permanentWard;
  final String formerMunicipality;
  final String formerProvince;
  final String formerWard;
  final bool verified;
  final List<DocumentEntity> personalDocs;
  UserEntity({
    this.message,
    this.id,
    this.citizenshipNumber,
    this.citizenshipIssueDistrict,
    this.firstName,
    this.middleName,
    this.lastName,
    this.applicantPhone,
    this.photoURL,
    this.birthDate,
    this.fatherName,
    this.formerProvince,
    this.motherName,
    this.spouseName,
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
    this.personalDocs,
    this.verified,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'id': id,
      'citizenshipNumber': citizenshipNumber,
      'citizenshipIssueDistrict': citizenshipIssueDistrict,
      'firstName': firstName,
      "middleName": middleName,
      "lastName": lastName,
      "spouseName": spouseName,
      'photoURL': photoURL,
      'applicantPhone': applicantPhone,
      'birthDate': birthDate,
      'fatherName': fatherName,
      'motherName': motherName,
      "formerProvince": formerProvince,
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
      'personalDocs': personalDocs,
    };
  }

  Map<String, dynamic> anotherToMap() {
    return {
      "नाम": "$firstName $middleName $lastName",
      "नागरिकता नम्बर": citizenshipNumber,
      "फोन": applicantPhone,
      "नागरिकता जारी जिल्ला": citizenshipIssueDistrict,
      "अस्थायी ठेगाना":
          "$temporaryProvince $temporaryDistrict $temporaryMunicipality $temporaryWard",
      "स्थाई ठेगाना":
          "$permanentProvince $permanentDistrict $permanentMunicipality $permanentWard",
      "जन्म मिति": birthDate,
      "साविकको गा.वि.स/नगरपालिका": formerMunicipality,
      "साविकको वडा": formerWard,
      "बुवाको नाम": fatherName,
      "आमाको नाम": motherName,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      message: map['message'],
      id: map['id'],
      citizenshipNumber: map['नागरिकता नम्बर'],
      citizenshipIssueDistrict: map['नागरिकता जारी जिल्ला'],
      firstName: map['पहिलो नाम'],
      lastName: map['थर'],
      middleName: map['बीचको नाम'],
      applicantPhone: map['निवेदकको फोन'],
      birthDate: map['जन्म मिति'],
      fatherName: map['बुवाको नाम'],
      motherName: map['आमाको नाम'],
      spouseName: map["पति/पत्नीको नाम"],
      temporaryProvince: map['अस्थायी प्रदेश'],
      temporaryDistrict: map['अस्थायी जील्ला'],
      temporaryMunicipality: map['अस्थायी पालिका'],
      temporaryWard: map['अस्थायी वडा'],
      permanentProvince: map['स्थायी प्रदेश'],
      permanentDistrict: map['स्थायी जील्ला'],
      permanentMunicipality: map['स्थायी पालिका'],
      permanentWard: map['स्थायी वडा'],
      formerProvince: map['साविकको प्रदेश'],
      formerMunicipality: map["साविकको गा.वि.स/नगरपालिका"],
      formerWard: map['साविकको वडा'],
      photoURL: map['photo_url'],
      // personalDocs: map['personal_documents'],
      verified: map['verified'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source));
  @override
  List<Object> get props => [
        message,
        id,
        firstName,
        middleName,
        lastName,
        applicantPhone,
        citizenshipNumber,
        citizenshipIssueDistrict,
        fatherName,
        motherName,
        birthDate,
        temporaryDistrict,
        formerProvince,
        spouseName,
        temporaryProvince,
        temporaryMunicipality,
        temporaryWard,
        permanentProvince,
        permanentDistrict,
        permanentMunicipality,
        permanentWard,
        verified,
        photoURL,
        formerMunicipality,
        formerWard,
      ];

  UserEntity copyWith({
    String message,
    String id,
    String citizenshipNumber,
    String citizenshipIssueDistrict,
    String firstName,
    String middleName,
    String lastName,
    String spouseName,
    String applicantPhone,
    String birthDate,
    String fatherName,
    String motherName,
    String temporaryProvince,
    String temporaryDistrict,
    String temporaryMunicipality,
    String temporaryWard,
    String permanentProvince,
    String permanentDistrict,
    String permanentMunicipality,
    String permanentWard,
    String formerProvince,
    String formerMunicipality,
    String photoURL,
    String formerWard,
    bool verified,
    List<DocumentEntity> personalDocs,
  }) {
    return UserEntity(
      message: message ?? this.message,
      id: id ?? this.id,
      citizenshipNumber: citizenshipNumber ?? this.citizenshipNumber,
      citizenshipIssueDistrict:
          citizenshipIssueDistrict ?? this.citizenshipIssueDistrict,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      applicantPhone: applicantPhone ?? this.applicantPhone,
      birthDate: birthDate ?? this.birthDate,
      fatherName: fatherName ?? this.fatherName,
      motherName: motherName ?? this.motherName,
      spouseName: spouseName ?? this.spouseName,
      temporaryProvince: temporaryProvince ?? this.temporaryProvince,
      temporaryDistrict: temporaryDistrict ?? this.temporaryDistrict,
      temporaryMunicipality:
          temporaryMunicipality ?? this.temporaryMunicipality,
      temporaryWard: temporaryWard ?? this.temporaryWard,
      permanentProvince: permanentProvince ?? this.permanentProvince,
      permanentDistrict: permanentDistrict ?? this.permanentDistrict,
      permanentMunicipality:
          permanentMunicipality ?? this.permanentMunicipality,
      permanentWard: permanentWard ?? this.permanentWard,
      formerProvince: formerProvince ?? this.formerProvince,
      formerMunicipality: formerMunicipality ?? this.formerMunicipality,
      formerWard: formerWard ?? this.formerWard,
      verified: verified ?? this.verified,
      photoURL: photoURL ?? this.photoURL,
      personalDocs: personalDocs ?? this.personalDocs,
    );
  }
}
