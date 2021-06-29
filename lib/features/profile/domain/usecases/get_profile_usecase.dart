import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:sifaris_app/core/domain/entities/document_entity.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/profile/domain/entities/profile_entity.dart';
import 'package:sifaris_app/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase extends UseCase<ProfileEntity, String> {
  final ProfileRepository profileRepository;
  GetProfileUseCase({
    @required this.profileRepository,
  });
  @override
  Future<Either<Failure, ProfileEntity>> call(String params) {
    return profileRepository.getProfile(token: params);
  }
}
