import 'package:dartz/dartz.dart';
import 'package:sifaris_app/core/domain/entities/organization_entity.dart';
import 'package:sifaris_app/core/error/failure.dart';

abstract class DataRepository {
  Future<Either<Failure, List<OrganizationEntity>>> getOrganization();
}
