import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sifaris_app/core/constants/app_colors.dart';
import 'package:sifaris_app/core/constants/enums.dart';
import 'package:sifaris_app/core/constants/nav_key.dart';
import 'package:sifaris_app/core/constants/text_constant.dart';
import 'package:sifaris_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:sifaris_app/features/auth/data/models/session_model.dart';
import 'package:sifaris_app/features/notification/data/datasource/notification_local_data_source.dart';
import 'package:sifaris_app/features/paper/presentation/pages/paper_status_page.dart';
import 'package:sifaris_app/features/profile/presentation/pages/user_profile_page.dart';
import 'package:sifaris_app/injection.dart';
part 'notification_count_state.dart';

class NotificationCountCubit extends Cubit<NotificationCountState> {
  NotificationCountCubit(
      {@required this.fcm,
      @required this.authLocalDataSource,
      @required this.notificationLocalDataSource})
      : super(NotificationCountState(count: 0));

  final FirebaseMessaging fcm;
  final AuthLocalDataSource authLocalDataSource;
  final NotificationLocalDataSource notificationLocalDataSource;

  final SharedPreferences sharedPreferences = getIt<SharedPreferences>();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    "High Importance Notifications",
    "This channel is used for important notifications.",
    importance: Importance.high,
    playSound: true,
  );
// initialize setting

  Future<void> init(BuildContext context) async {
    // initialize notification settings
    final initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    int count = sharedPreferences.getInt(NOTIFICATION_COUNT);
    notificationLocalDataSource.persistNotificationCount(count ?? 0);
    emit(NotificationCountState(
        count: sharedPreferences.getInt(NOTIFICATION_COUNT) ?? 0));
    SessionModel session = await authLocalDataSource.getSession();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      var notifData = message.data;
      if (notification != null) {
        if (notifData['type'] == "Citizen Details Verification") {
          session.verificationStatus = "Verified";
          session.verificationEnum = VerificationEnum.Verified.toString();
          authLocalDataSource.persistSession(session: session);

          notificationLocalDataSource.persistNotificationCount(
              sharedPreferences.getInt(NOTIFICATION_COUNT) + 1);
        }
        if (notifData['type'] == 'Paper Create' ||
            notifData['type'] == 'Citizen Details Verification' ||
            notifData['type'] == 'Paper Verification') {
          notificationLocalDataSource.persistNotificationCount(
              sharedPreferences.getInt(NOTIFICATION_COUNT) + 1);
        }

        int newCount = sharedPreferences.getInt(NOTIFICATION_COUNT);
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: notifData['type'],
        );
        flutterLocalNotificationsPlugin.initialize(initializationSettings,
            onSelectNotification: onSelectNotification);
        emit(NotificationCountState(count: newCount));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;

      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            color: AppColors.blueColor,
            playSound: true,
            icon: '@mipmap/ic_launcher',
          )));
    });
  }

  Future<dynamic> onSelectNotification(payload) async {
    if (payload == "Paper Create") {
      navigatorKey.currentState.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => UserProfilePage()),
          (route) => true);
    }
  }
}
