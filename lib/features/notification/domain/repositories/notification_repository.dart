import 'package:dartz/dartz.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:sifaris_app/features/notification/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(
      {String token});
}
