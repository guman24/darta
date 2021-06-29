import 'package:shared_preferences/shared_preferences.dart';
import 'package:sifaris_app/core/constants/text_constant.dart';

abstract class NotificationLocalDataSource {
  Future<void> persistNotificationCount(int count);
}

class INotificationLocalDataSource implements NotificationLocalDataSource {
  final SharedPreferences sharedPreferences;

  INotificationLocalDataSource(this.sharedPreferences);

  @override
  Future<void> persistNotificationCount(int count) {
    return sharedPreferences.setInt(NOTIFICATION_COUNT, count);
  }
}
