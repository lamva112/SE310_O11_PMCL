import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../core/core.dart';

class NetworkDependencies {
  static Future setup(GetIt injector) async {
    final authorizationInterceptor = AuthorizationInterceptor();

    // network checker
    injector.registerLazySingleton(() => InternetConnectionCheckerPlus());
    injector.registerLazySingleton<INetworkInfo>(() => NetworkInfo(injector()));

    // network utility for request
    injector.registerLazySingleton<INetworkUtility>(
      () => NetworkUtility(
        'BASE_URL',
        interceptors: [authorizationInterceptor],
      ),
      instanceName: NetworkConstant.authorizationDomain,
    );
  }
}
