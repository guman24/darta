import 'package:dartz/dartz.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/features/notice/domain/entities/notice_entity.dart';

abstract class NoticeRepository {
  Future<Either<Failure, List<NoticeEntity>>> getNotices({String token});
}
