import 'package:get_it/get_it.dart';

import '../data/data.dart';

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
    injector.registerFactory<IVocabularyRepository>(() => VocabularyRepository(
          remoteService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<ITestRepository>(() => TestReppsitory(
          remoteService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<IQuestionRepository>(() => QuestionRepository(
          remoteService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<IOptionRepository>(() => OptionRepository(
          remoteService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<IAuthRepository>(() => AuthRepository(
          remoteService: injector(),
          networkInfo: injector(),
        ));
    injector.registerFactory<ISharedPreferencesRepository>(
        () => SharedPreferencesRepository(injector()));
  }
}
