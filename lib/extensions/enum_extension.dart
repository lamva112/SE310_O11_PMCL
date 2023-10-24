import '../enums.dart';

extension EnvironmentExtension on Environment {
  String get value => ['dev', 'staging', 'prod'][index];
}

extension GetPath on FlareEnum {
  String get rawValue {
    switch (this) {
      case FlareEnum.background:
        return "assets/animation/$name.flr";
    }
  }
}
