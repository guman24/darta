import 'package:get_it/get_it.dart';
import 'package:sifaris_app/features/notice/domain/repositories/notice_repository.dart';
import 'package:sifaris_app/features/notification/data/datasource/notification_local_data_source.dart';
import 'package:sifaris_app/features/notification/data/datasource/notification_remote_data_source.dart';
import 'package:sifaris_app/features/notification/data/repositories/I_notification_repository.dart';
import 'package:sifaris_app/features/notification/domain/repositories/notification_repository.dart';
import 'package:sifaris_app/features/notification/domain/usecases/get_notifications_usecase.dart';
import 'package:sifaris_app/features/notification/presentation/blocs/notification/notification_bloc.dart';
import 'package:sifaris_app/features/notification/presentation/blocs/notification_count/notification_count_cubit.dart';

final sl = GetIt.instance;

Future<void> notificationInjection() async {
  // !USE CASES
  sl.registerLazySingleton(() => GetNotificationsUseCase(sl()));

  // !BLOCS
  sl.registerLazySingleton(() => NotificationBloc(sl(), sl()));
  sl.registerLazySingleton(() => NotificationCountCubit(
      fcm: sl(), authLocalDataSource: sl(), notificationLocalDataSource: sl()));

  // !DATA SOURCES
  sl.registerLazySingleton<NotificationRemoteDataSource>(
      () => INotificationRemoteDataSource());
  sl.registerLazySingleton<NotificationLocalDataSource>(
      () => INotificationLocalDataSource(sl()));

  // !REPOSITORIES
  sl.registerLazySingleton<NotificationRepository>(
      () => INotificationRepository(sl(), sl()));
}
