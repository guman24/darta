import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sifaris_app/core/domain/entities/organization_entity.dart';

import 'package:sifaris_app/core/domain/repositories/data_repository.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';

class OrganizationUseCase extends UseCase {
  final DataRepository dataRepository;
  OrganizationUseCase({
    @required this.dataRepository,
  });
  @override
  Future<Either<Failure, List<OrganizationEntity>>> call(params) {
    return dataRepository.getOrganization();
  }
}
