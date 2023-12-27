import 'package:get_it/get_it.dart';

import '../data/data.dart';

class RemoteServiceDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<ISplashRemoteService>(() => SplashRemoteService());
    injector.registerFactory<ISearchRemoteService>(() => SearchRemoteService());
    injector.registerFactory<IUnitRemoteService>(() => UnitRemoteService());
    injector.registerFactory<IVocabularyRemoteService>(() => VocabularyRemoteService());
    injector.registerFactory<ITestRemoteService>(() => TestRemoteService());
    injector.registerFactory<IQuestionRemoteService>(() => QuestionRemoteService());
    injector.registerFactory<IOptionRemoteService>(() => OptionRemoteService());
    injector.registerFactory<IAuthRemoteService>(() => AuthRemoteService());
  }
}
