import 'package:sifaris_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sifaris_app/core/usecases/usecase.dart';
import 'package:sifaris_app/features/notice/domain/entities/notice_entity.dart';
import 'package:sifaris_app/features/notification/domain/entities/notification_entity.dart';
import 'package:sifaris_app/features/notification/domain/repositories/notification_repository.dart';

class GetNotificationsUseCase
    extends UseCase<List<NotificationEntity>, String> {
  final NotificationRepository notificationRepository;

  GetNotificationsUseCase(this.notificationRepository);
  @override
  Future<Either<Failure, List<NotificationEntity>>> call(String params) {
    return notificationRepository.getNotifications(token: params);
  }
}
