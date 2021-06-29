import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/auth/domain/repositories/auth_repository.dart';

class OtpVerifyUseCase extends UseCase<Map<String, dynamic>, VerifyParams> {
  final AuthRepository authRepository;
  OtpVerifyUseCase({
    @required this.authRepository,
  });

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(VerifyParams params) {
    return authRepository.verifyOtp(data: params.toMap());
  }
}

class VerifyParams {
  final String userId;
  final String otp;
  VerifyParams({
    @required this.userId,
    @required this.otp,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'otp': otp,
    };
  }

  factory VerifyParams.fromMap(Map<String, dynamic> map) {
    return VerifyParams(
      userId: map['userId'],
      otp: map['otp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyParams.fromJson(String source) =>
      VerifyParams.fromMap(json.decode(source));
}
