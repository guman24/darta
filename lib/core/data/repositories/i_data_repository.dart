import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:sifaris_app/core/data/datasources/remote_datasource.dart';
import 'package:sifaris_app/core/data/models/organization_model.dart';
import 'package:sifaris_app/core/domain/repositories/data_repository.dart';
import 'package:sifaris_app/core/error/exception.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/network/network_info.dart';

class IDataRepository extends DataRepository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  IDataRepository({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<OrganizationModel>>> getOrganization() async {
    if (await networkInfo.isConncected) {
      try {
        final responseData = await remoteDataSource.getOrganization();
        return Right(responseData);
      } on ServerException catch (err) {
        return Left(ServerFailure(message: err.message));
      }
    } else {
      return Left(ServerFailure(message: "No Internet Connection"));
    }
  }
}
