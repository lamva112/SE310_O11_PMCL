
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfo implements INetworkInfo {
  final InternetConnectionCheckerPlus dataConnectionChecker;

  NetworkInfo(this.dataConnectionChecker);

  @override
  Future<bool> get isConnected async => dataConnectionChecker.hasConnection;
}
