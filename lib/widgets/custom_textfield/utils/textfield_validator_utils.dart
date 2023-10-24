class TextFieldValidatorUtils {
  static String _regexEmail = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static String _regexPhone = r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$';
  static String _regexName = r'^.{1,50}$';
  static String _regexPwd = r'^(?=.*[a-z])(?=.*\d).{8,16}$';

  static String? validateEmail(String? value, {String? errorMessage}) {
    if (value == null || value.isEmpty) {
      return null;
    }

    var result = RegExp(_regexEmail).hasMatch(value);
    if (result) {
      return null;
    } else {
      return errorMessage ?? 'Email is not valid!';
    }
  }

  static String? validatePhoneNumber(String? value, {String? errorMessage, bool allowValueNull = false}) {
    if (allowValueNull == false) {
      if (value == null || value.isEmpty) {
        return errorMessage;
      }

      var result = RegExp(_regexPhone).hasMatch(value);
      if (result) {
        return null;
      } else {
        return errorMessage ?? 'Phone is not valid!';
      }
    } else {
      if (value == null || value.isEmpty) {
        return null;
      }

      var result = RegExp(_regexPhone).hasMatch(value);
      if (result) {
        return null;
      } else {
        return errorMessage ?? 'Phone is not valid!';
      }
    }
  }

  static String? validateName(String? value, {String? errorMessage}) {
    if (value == null || value.isEmpty) {
      return null;
    }

    var result = RegExp(_regexName).hasMatch(value);
    if (result) {
      return null;
    } else {
      return errorMessage ?? 'Name is not valid';
    }
  }

  static String? validatePassword(String? value, {String? errorMessage}) {
    if (value == null || value.isEmpty) {
      return null;
    }

    var result = RegExp(_regexPwd).hasMatch(value);
    if (result) {
      return null;
    } else {
      return errorMessage ?? 'Password is not valid!';
    }
  }
}
