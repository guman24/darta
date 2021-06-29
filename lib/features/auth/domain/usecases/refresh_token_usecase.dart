import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/auth/domain/repositories/auth_repository.dart';

class RefreshTokenUseCase extends UseCase<Map<String, dynamic>, String> {
  final AuthRepository authRepository;
  RefreshTokenUseCase({
    @required this.authRepository,
  });

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(String params) {
    return authRepository.refreshToken(token: params);
  }
}
