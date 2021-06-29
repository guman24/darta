import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/kyc/domain/entities/former_ward_entity.dart';
import 'package:sifaris_app/features/kyc/domain/repositories/kyc_verification_repository.dart';

class FormerWardUseCase extends UseCase<List<FormerWardEntity>, String> {
  final KycVerificationRepository kycVerificationRepository;
  FormerWardUseCase({
    @required this.kycVerificationRepository,
  });
  @override
  Future<Either<Failure, List<FormerWardEntity>>> call(String params) {
    return kycVerificationRepository.getFormerWards(token: params);
  }
}
