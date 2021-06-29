import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase extends UseCase<Map<String, dynamic>, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(LoginParams params) {
    return authRepository.login(data: params.toMap());
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;
  final String fcm;

  LoginParams({
    @required this.email,
    @required this.password,
    @required this.fcm,
  });

  @override
  List<Object> get props => [email, password, fcm];

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'fcm_token': fcm,
    };
  }

  factory LoginParams.fromMap(Map<String, dynamic> map) {
    return LoginParams(
      email: map['email'],
      password: map['password'],
      fcm: map['fcm'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginParams.fromJson(String source) =>
      LoginParams.fromMap(json.decode(source));
}
