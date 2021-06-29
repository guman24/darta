import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/auth/domain/entities/user_entity.dart';
import 'package:sifaris_app/features/kyc/domain/repositories/kyc_verification_repository.dart';

class VerificationDetailsUseCase extends UseCase<UserEntity, String> {
  final KycVerificationRepository kycVerificationRepository;
  VerificationDetailsUseCase({
    @required this.kycVerificationRepository,
  });
  @override
  Future<Either<Failure, UserEntity>> call(String params) {
    return kycVerificationRepository.getVerificationDetails(token: params);
  }
}
