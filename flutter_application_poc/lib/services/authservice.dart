class AuthService {
  static const String _validEmail = 'JohnDoe@emails.com';
  static const String _password = 'Password123!';

  static Future<bool> signIn(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    return email.trim() == _validEmail &&
           password == _password;
  }
}