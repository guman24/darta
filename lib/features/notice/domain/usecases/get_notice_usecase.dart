import 'package:sifaris_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/notice/domain/entities/notice_entity.dart';
import 'package:sifaris_app/features/notice/domain/repositories/notice_repository.dart';

class GetNoticeUseCase extends UseCase<List<NoticeEntity>, String> {
  final NoticeRepository noticeRepository;

  GetNoticeUseCase(this.noticeRepository);
  @override
  Future<Either<Failure, List<NoticeEntity>>> call(String params) {
    return noticeRepository.getNotices(token: params);
  }
}
