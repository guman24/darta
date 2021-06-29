import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sifaris_app/core/data/datasources/remote_datasource.dart';
import 'package:sifaris_app/core/domain/entities/document_entity.dart';
import 'package:sifaris_app/core/domain/entities/organization_entity.dart';
import 'package:sifaris_app/core/error/exception.dart';

import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/network/network_info.dart';
import 'package:sifaris_app/features/auth/domain/entities/user_entity.dart';
import 'package:sifaris_app/features/kyc/data/datasources/kyc_remote_datasource.dart';
import 'package:sifaris_app/features/kyc/domain/entities/former_ward_entity.dart';
import 'package:sifaris_app/features/kyc/domain/repositories/kyc_verification_repository.dart';

class IKycVerificationRepository extends KycVerificationRepository {
  final KycRemoteDataSource kycRemoteDataSource;
  final RemoteDataSource coreRemoteDataSource;
  final NetworkInfo networkInfo;
  IKycVerificationRepository({
    @required this.kycRemoteDataSource,
    @required this.networkInfo,
    @required this.coreRemoteDataSource,
  });

  // ! VERIFY KYC FORM
  @override
  Future<Either<Failure, String>> kycVerify(
      {Map<String, dynamic> data,
      String token,
      List<DocumentEntity> files,
      String userPhotoURl}) async {
    if (await networkInfo.isConncected) {
      try {
        final verifyResponse = await kycRemoteDataSource.kycVerify(
            data: data, token: token, files: files, userPhotoURL: userPhotoURl);
        return Right(verifyResponse);
      } on ServerException catch (error) {
        return Left(ServerFailure(message: error.message.toString()));
      }
    } else {
      return Left(
          ServerFailure(message: "No internet connection. Plase try again."));
    }
  }

  @override
  Future<Either<Failure, List<FormerWardEntity>>> getFormerWards(
      {String token}) async {
    if (await networkInfo.isConncected) {
      try {
        final formerWardResponse =
            await kycRemoteDataSource.getFormerWards(token: token);
        return Right(formerWardResponse);
      } on ServerException catch (error) {
        return Left(ServerFailure(message: error.message.toString()));
      }
    } else {
      return Left(
          ServerFailure(message: "No internet connection. Plase try again."));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getVerificationDetails(
      {String token}) async {
    if (await networkInfo.isConncected) {
      try {
        final response =
            await kycRemoteDataSource.getVerificationDetails(token: token);
        return Right(response);
      } on ServerException catch (error) {
        return Left(ServerFailure(message: error.message.toString()));
      }
    } else {
      return Left(
          ServerFailure(message: "No internet connection. Plase try again."));
    }
  }

  // ! Get individual documents for this municipality
  @override
  Future<Either<Failure, List<String>>> getIndividualDocuments() async {
    if (await networkInfo.isConncected) {
      try {
        final List<OrganizationEntity> response =
            await coreRemoteDataSource.getOrganization();
        return Right(response[0].individualDocuments);
      } on ServerException catch (error) {
        return Left(ServerFailure(message: error.message.toString()));
      }
    } else {
      return Left(
          ServerFailure(message: "No internet connection. Plase try again."));
    }
  }
}
