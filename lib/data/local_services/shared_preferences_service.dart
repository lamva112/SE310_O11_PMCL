import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../data.dart';

class SharedPreferencesService implements ISharedPreferencesService {
  final SharedPreferences sharedPreferences;

  SharedPreferencesService({required this.sharedPreferences});

  @override
  Future<bool> changeLanguage(String languageCode) async {
    return await sharedPreferences.setString(SharedPreferencesKey.languageCode, languageCode);
  }

  @override
  String? getLanguage() {
    return sharedPreferences.getString(SharedPreferencesKey.languageCode);
  }

  @override
  Future<bool> changeToken(String token) async {
    return await sharedPreferences.setString(SharedPreferencesKey.token, token);
  }

  @override
  String? getToken() {
    return sharedPreferences.getString(SharedPreferencesKey.token);
  }

  @override
  Future<bool> removeToken() {
    return sharedPreferences.remove(SharedPreferencesKey.token);
  }

  @override
  Future<bool> setUserPassedOnBoarding(bool value) {
    return sharedPreferences.setBool(SharedPreferencesKey.userPassedOnBoarding, value);
  }

  @override
  bool? checkIsUserPassedOnBoarding() {
    return sharedPreferences.getBool(SharedPreferencesKey.userPassedOnBoarding);
  }
}