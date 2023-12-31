import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Routes {
  static String get splash => '/splash';
  static String get authentication => '/authentication';
  static String get home => '/home';
  static String get search => '/search';
  static String get vocabulary => '/vocabulary';
  static String get searchDetail => '/searchDetail';
  static String get vocabularyDetail => '/vocabularyDetail';
  static String get prepare => '/prepare';
  static String get testDetail => '/testDetail';
  static String get favorite => '/favorite';

  static getRoute(RouteSettings settings) {
    Widget widget;
    try {
      widget = GetIt.I.get<Widget>(instanceName: settings.name);
    } catch (e) {
      widget = Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Builder(
            builder: (context) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
                child: Text(
                  '404 NOT FOUND',
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      );
    }
    return CupertinoPageRoute(builder: (_) => widget, settings: settings);
  }
}
