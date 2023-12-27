import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../pages/pages.dart';
import '../pages/web/favorite/favorite_page.dart';
import '../router/router.dart';

class PageDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<Widget>(() => SplashPage(injector()), instanceName: Routes.splash);
    injector.registerFactory<Widget>(() => LoginPage(bloc: injector(),), instanceName: Routes.authentication);
    injector.registerFactory<Widget>(() => Workspace(bloc:injector(),searchBloc:injector(),vocabularyBloc:injector(),testBloc:injector(),favoriteBloc: injector(),), instanceName: Routes.home);
    injector.registerFactory<Widget>(() => SearchPage(bloc:injector(),), instanceName: Routes.search);
    injector.registerFactory<Widget>(() => VocabularyPage(bloc:injector(),), instanceName: Routes.vocabulary);
    injector.registerFactory<Widget>(() => SearchDetailPage(bloc:injector(),), instanceName: Routes.searchDetail);
    injector.registerFactory<Widget>(() => VocabularyDetailPage(bloc:injector(),), instanceName: Routes.vocabularyDetail);
    injector.registerFactory<Widget>(() => PreparePage(bloc:injector()), instanceName: Routes.prepare);
    injector.registerFactory<Widget>(() => TestDetailPage(bloc:injector()), instanceName: Routes.testDetail);
    injector.registerFactory<Widget>(() => FavoritePage(bloc:injector()), instanceName: Routes.favorite);
  }
}
