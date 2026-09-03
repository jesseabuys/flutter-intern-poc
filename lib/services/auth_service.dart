import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'loginToken';
  static const String _demoToken = 'POC_LOGIN_TOKEN_2026_ABC123';

  static Future<bool> signIn(
    String email,
    String password,
  ) async {
    if (email == 'JohnDoe@emails.com' &&
        password == 'Password123!') {

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
        _tokenKey,
        _demoToken,
      );

      return true;
    }

    return false;
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString(_tokenKey);

    return token == _demoToken;
  }
}