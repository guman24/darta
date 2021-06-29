import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sifaris_app/core/error/exception.dart';

import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/network/network_info.dart';
import 'package:sifaris_app/features/template/data/datasources/template_remote_datasource.dart';
import 'package:sifaris_app/features/template/domain/entities/template_category_entity.dart';
import 'package:sifaris_app/features/template/domain/entities/template_entity.dart';
import 'package:sifaris_app/features/template/domain/respositories/template_repository.dart';

class ITemplateRepository extends TemplateRepository {
  final NetworkInfo networkInfo;
  final TemplateRemoteSource templateRemoteSource;
  ITemplateRepository({
    @required this.networkInfo,
    @required this.templateRemoteSource,
  });
  @override
  Future<Either<Failure, List<TemplateEntity>>> getTemplates(
      {String token}) async {
    if (await networkInfo.isConncected) {
      try {
        final templates = await templateRemoteSource.getTempaltes(token: token);
        return Right(templates);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(
          message: "No internet connection, plase try again later"));
    }
  }

  @override
  Future<Either<Failure, List<TemplateCategoryEntity>>> getTemplatesCategory(
      {String token}) async {
    if (await networkInfo.isConncected) {
      try {
        final templates =
            await templateRemoteSource.getTemplatesCategory(token: token);
        return Right(templates);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(
          message: "No internet connection, plase try again later"));
    }
  }

  @override
  Future<Either<Failure, List<TemplateEntity>>> getPopularTemplates(
      {String token}) async {
    if (await networkInfo.isConncected) {
      try {
        final templates =
            await templateRemoteSource.getPopularTempates(token: token);
        return Right(templates);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure(
          message: "No internet connection, plase try again later"));
    }
  }
}
