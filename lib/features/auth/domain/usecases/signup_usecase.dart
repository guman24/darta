import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase extends UseCase<Map<String, dynamic>, SignUpParams> {
  final AuthRepository authRepository;

  SignupUseCase(this.authRepository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(params) {
    return authRepository.register(data: params.toMap());
  }
}

class SignUpParams extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String departmentId;
  final String gender;
  final String organizationId;
  final String citizenshipNumber;
  final String addressType;
  final String phone;
  SignUpParams({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.password,
    @required this.addressType,
    @required this.gender,
    @required this.departmentId,
    @required this.organizationId,
    @required this.citizenshipNumber,
    @required this.phone,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        password,
        email,
        departmentId,
        organizationId,
        gender,
        addressType,
        citizenshipNumber,
        phone,
      ];

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'department_id': departmentId,
      'organization_id': organizationId,
      'citizenship_number': citizenshipNumber,
      'phone': phone,
      'gender': gender,
      'address_type': addressType,
    };
  }

  factory SignUpParams.fromMap(Map<String, dynamic> map) {
    return SignUpParams(
        firstName: map['first_name'],
        lastName: map['last_name'],
        email: map['email'],
        password: map['password'],
        departmentId: map['department_id'],
        organizationId: map['organization_id'],
        citizenshipNumber: map['citizenship_number'],
        addressType: map['address_type'],
        phone: map['phone'],
        gender: map['gender']);
  }

  String toJson() => json.encode(toMap());

  factory SignUpParams.fromJson(String source) =>
      SignUpParams.fromMap(json.decode(source));
}
