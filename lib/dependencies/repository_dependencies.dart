import 'package:get_it/get_it.dart';

import '../data/data.dart';
import '../data/repositories/search_repository.dart';

class RepositoryDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<ISplashRepository>(() => SplashRepository(
          remoteService: injector(),
          localService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<ISearchRepository>(() => SearchRepository(
          remoteService: injector(),
          networkInfo: injector(),
        ));
        injector.registerFactory<IUnitRepository>(() => UnitReppsitory(
          remoteService: injector(),
          networkInfo: injector(),
        ));
  }
}
