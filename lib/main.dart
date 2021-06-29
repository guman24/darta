import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sifaris_app/core/constants/nav_key.dart';
import 'package:sifaris_app/core/constants/text_constant.dart';
import 'package:sifaris_app/core/constants/themes.dart';
import 'package:sifaris_app/core/data/datasources/local_datasource.dart';
import 'package:sifaris_app/features/auth/presentation/blocs/auth/auth_cubit.dart';
import 'package:sifaris_app/features/auth/presentation/pages/auth/first_page.dart';
import 'package:sifaris_app/features/auth/presentation/pages/auth/login_page.dart';
import 'package:sifaris_app/features/auth/presentation/pages/splash_page.dart';
import 'package:sifaris_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'features/notification/presentation/blocs/notification_count/notification_count_cubit.dart';
import 'injection.dart';
import 'injection_container.dart' as di;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message ${message.messageId}");
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  "High Importance Notifications",
  "This channel is used for important notifications.",
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _installFlag;
  @override
  void initState() {
    super.initState();
    getIt<NotificationCountCubit>()..init(context);
    _setInstallFlag();
  }

  Future<void> _setInstallFlag() async {
    final localSource = getIt<LocalDataResource>();
    _installFlag = await localSource.getInstallFlag();
    if (_installFlag == null) {
      localSource.setInstallFlag();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthCubit>()..checkAuthStatus(),
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return MaterialApp(
            theme: AppTheme.lightTheme,
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            // home: context.select(
            //   (AuthCubit authCubit) => authCubit.state.showSplash
            //       ? SplashPage()
            //       : (authCubit.state.authenticated
            //           ? DashBoardPage()
            //           : FirstPage()),
            // ),
            home: state.showSplash
                ? SplashPage()
                : (state.authenticated
                    ? DashBoardPage()
                    : (_installFlag == true ? LoginPage() : FirstPage())),
            // home: Home(),
          );
        },
      ),
    );
  }
}
