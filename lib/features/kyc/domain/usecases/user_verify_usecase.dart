import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sifaris_app/core/domain/entities/document_entity.dart';

import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/kyc/domain/repositories/kyc_verification_repository.dart';

class UserVerifyUseCase extends UseCase<String, UserVerifyParams> {
  final KycVerificationRepository kycVerificationRepository;

  UserVerifyUseCase(this.kycVerificationRepository);

  @override
  Future<Either<Failure, String>> call(UserVerifyParams params) {
    return kycVerificationRepository.kycVerify(
        token: params.token,
        data: params.data,
        files: params.files,
        userPhotoURl: params.userPhotoURL);
  }
}

class UserVerifyParams {
  String token;
  Map<String, dynamic> data;
  List<DocumentEntity> files;
  String userPhotoURL;
  UserVerifyParams({
    @required this.token,
    @required this.data,
    @required this.files,
    @required this.userPhotoURL,
  });
}
