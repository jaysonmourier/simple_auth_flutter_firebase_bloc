class Validator {
  // regex for email validation
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // regex for password validation
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  /// Validate email
  static bool isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  /// Validate password
  static bool isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
