import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sifaris_app/core/error/exception.dart';

import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/network/network_info.dart';
import 'package:sifaris_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:sifaris_app/features/profile/domain/entities/profile_entity.dart';
import 'package:sifaris_app/features/profile/domain/repositories/profile_repository.dart';

class IProfileRepository extends ProfileRepository {
  final NetworkInfo networkInfo;
  final ProfileRemoteDataSource profileRemoteDataSource;
  IProfileRepository({
    @required this.networkInfo,
    @required this.profileRemoteDataSource,
  });
  @override
  Future<Either<Failure, ProfileEntity>> getProfile({String token}) async {
    if (await networkInfo.isConncected) {
      try {
        final profileResponse =
            await profileRemoteDataSource.getProfile(token: token);
        return Right(profileResponse);
      } on ServerException catch (er) {
        return Left(ServerFailure(message: er.message));
      }
    } else {
      return Left(
          ServerFailure(message: "No Internet Connection. Plase try again"));
    }
  }
}
