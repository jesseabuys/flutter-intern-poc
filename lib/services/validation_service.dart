class ContactValidator {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address.';
    }

    if (!value.contains('@') || !value.contains('.')) {
      return 'Please enter a valid email.';
    }

    return null;
  }

    static String? validatePassword(String? value) {
    if (value == null || value.isEmpty || value.length < 8) {
      return 'Please enter a valid password.';
    }

    return null;
  }

  static String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your message.';
    }

    return null;
  }
}