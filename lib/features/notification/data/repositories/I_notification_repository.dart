import 'package:sifaris_app/core/error/exception.dart';
import 'package:sifaris_app/core/network/network_info.dart';
import 'package:sifaris_app/features/notice/data/datasource/notice_remote_datasource.dart';
import 'package:sifaris_app/features/notice/domain/entities/notice_entity.dart';
import 'package:sifaris_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sifaris_app/features/notification/data/datasource/notification_remote_data_source.dart';
import 'package:sifaris_app/features/notification/domain/entities/notification_entity.dart';
import 'package:sifaris_app/features/notification/domain/repositories/notification_repository.dart';

class INotificationRepository extends NotificationRepository {
  final NetworkInfo networkInfo;
  final NotificationRemoteDataSource notificationRemoteDataSource;

  INotificationRepository(this.networkInfo, this.notificationRemoteDataSource);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(
      {String token}) async {
    if (await networkInfo.isConncected) {
      try {
        final notifications =
            await notificationRemoteDataSource.getNotifications(token: token);
        return Right(notifications);
      } on ServerException catch (error) {
        return Left(ServerFailure(message: error.message.toString()));
      }
    } else {
      return Left(
          ServerFailure(message: "No internet connection. Plase try again."));
    }
  }
}
