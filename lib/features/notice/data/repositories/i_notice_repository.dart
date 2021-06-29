import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sifaris_app/core/error/exception.dart';

import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/core/network/network_info.dart';
import 'package:sifaris_app/features/notice/data/datasource/notice_remote_datasource.dart';
import 'package:sifaris_app/features/notice/domain/entities/notice_entity.dart';
import 'package:sifaris_app/features/notice/domain/repositories/notice_repository.dart';

class INoticeRepository extends NoticeRepository {
  final NoticeRemoteDataSource noticeRemoteDataSource;
  final NetworkInfo networkInfo;
  INoticeRepository({
    @required this.noticeRemoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<NoticeEntity>>> getNotices({String token}) async {
    if (await networkInfo.isConncected) {
      try {
        final noticeResponse =
            await noticeRemoteDataSource.getNotices(token: token);
        return Right(noticeResponse);
      } on ServerException catch (error) {
        return Left(ServerFailure(message: error.message.toString()));
      }
    } else {
      return Left(
          ServerFailure(message: "No internet connection. Plase try again."));
    }
  }
}
