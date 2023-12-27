abstract class ISharedPreferencesService {
  String? getLanguage();

  Future<bool> changeLanguage(String languageCode);

  String? getToken();

  Future<bool> changeToken(String token);

  Future<bool> removeToken();

  Future<bool> setUserPassedOnBoarding(bool value);

  bool? checkIsUserPassedOnBoarding();
}