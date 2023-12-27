abstract class ISharedPreferencesRepository {
  String? getLanguage();

  Future<bool> changeLanguage(String languageCode);

  String? getToken();

  Future<bool> changeToken(String token);

  Future<bool> removeToken();

  Future<bool> setUserPassedOnBoardingPage(bool value);

  bool? checkIsUserPassedOnBoarding();
}