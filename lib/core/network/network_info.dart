import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConncected;
}

class INetworkInfo implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  INetworkInfo(this.connectionChecker);

  @override
  Future<bool> get isConncected => connectionChecker.hasConnection;
}
