class Validator {
  static String? valueExists(dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return 'Please fill this field';
    } else {
      return null;
    }
  }

  static String? passwordCorrect(dynamic value) {
    final emptyResult = valueExists(value);
    if (emptyResult == null || emptyResult.isEmpty) {
      const pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[#?!@$%^&*-]).{8,}$';
      final regExp = RegExp(pattern);
      if (!regExp.hasMatch(value.toString())) {
        return r'Your password must be at least 8 symbols with number, big and small letter and special character (!@#\$%^&*).';
      } else {
        return null;
      }
    } else {
      return emptyResult;
    }
  }

  static String? validateEmail(dynamic value) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(pattern);
    final emptyResult = valueExists(value);
    if (emptyResult != null) {
      return emptyResult;
    } else if (!regExp.hasMatch(value.toString())) {
      return 'Not a valid email address. Should be your@email.com';
    } else {
      return null;
    }
  }
}
