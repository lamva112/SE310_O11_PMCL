import 'package:get_it/get_it.dart';

import '../blocs/blocs.dart';

class BlocDependencies {
  static Future setup(GetIt injector) async {
    injector.registerLazySingleton(() => AppBloc());
    injector.registerFactory<SplashBloc>(() => SplashBloc(injector()));
    injector.registerFactory<LoginBloc>(() => LoginBloc());
    injector.registerFactory<HomeBloc>(() => HomeBloc());
    injector.registerFactory<WorkspaceBloc>(() => WorkspaceBloc());
    injector.registerFactory<SearchBloc>(() => SearchBloc(injector()));
    injector.registerFactory<VocabularyBloc>(() => VocabularyBloc(injector()));
    injector.registerFactory<SearchDetailBloc>(() => SearchDetailBloc(injector()));
    injector.registerFactory<VocabularyDetailBloc>(() => VocabularyDetailBloc());
  }
}
