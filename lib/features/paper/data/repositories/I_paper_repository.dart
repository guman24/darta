import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sifaris_app/core/domain/entities/document_entity.dart';
import 'package:sifaris_app/core/error/exception.dart';

import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/network/network_info.dart';
import 'package:sifaris_app/features/paper/data/datasources/paper_remote_datasource.dart';
import 'package:sifaris_app/features/paper/domain/entities/paper_entity.dart';
import 'package:sifaris_app/features/paper/domain/repositories/paper_repository.dart';

class IPaperRepository extends PaperRepository {
  final NetworkInfo networkInfo;
  final PaperRemoteDataSource paperRemoteDataSource;
  IPaperRepository({
    @required this.networkInfo,
    @required this.paperRemoteDataSource,
  });

  @override
  Future<Either<Failure, String>> paperCreate(
      {Map<String, dynamic> data,
      String token,
      List<DocumentEntity> documents,
      Map<String, dynamic> newAttributes}) async {
    if (await networkInfo.isConncected) {
      try {
        final paperCreateResponse =
            await paperRemoteDataSource.paperCreateRequest(
                data: data,
                token: token,
                documents: documents,
                newAttributes: newAttributes);
        return Right(paperCreateResponse);
      } on ServerException catch (error) {
        return Left(ServerFailure(message: error.message.toString()));
      }
    } else {
      return Left(
          ServerFailure(message: "No internet connection. Plase try again."));
    }
  }

  @override
  Future<Either<Failure, List<PaperEntity>>> getPapers({String token}) async {
    if (await networkInfo.isConncected) {
      try {
        final paperResponse = await paperRemoteDataSource.getPapers(
          token: token,
        );
        return Right(paperResponse);
      } on ServerException catch (error) {
        return Left(ServerFailure(message: error.message.toString()));
      }
    } else {
      return Left(
          ServerFailure(message: "No internet connection. Plase try again."));
    }
  }
}
