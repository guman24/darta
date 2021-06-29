import 'package:shared_preferences/shared_preferences.dart';
import 'package:sifaris_app/core/constants/text_constant.dart';

abstract class LocalDataResource {
  Future<void> setInstallFlag();
  Future<bool> getInstallFlag();
}

class ILocalDataSource implements LocalDataResource {
  final SharedPreferences sharedPreferences;

  ILocalDataSource(this.sharedPreferences);
  @override
  Future<bool> getInstallFlag() async {
    return sharedPreferences.getBool(INSTALL_FLAG);
  }

  @override
  Future<void> setInstallFlag() async {
    sharedPreferences.setBool(INSTALL_FLAG, true);
  }
}
