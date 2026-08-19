import 'package:flutter_application_poc/services/auth_service.dart';
import 'package:test/test.dart';

// Class containing unit tests for authentication service
void main() {
  group('Test start, Valid login, invalid email, invalid password.', () {
    // 1st test is checking the hardcoded credentials work
    test('True for valid credentials', () async {
      final result = await AuthService.signIn('JohnDoe@emails.com', 'Password123!');
      expect(result, isTrue);
    });

    // 2nd test is checking invalid email, valid password returns false
    test('False for invalid email', () async {
      final result = await AuthService.signIn('jesseabuys@email.com', 'Passwords123!');
      expect(result, isFalse);
    });

    // 3rd test is a check for an invalid password
    test('False for invalid password', () async {
      final result = await AuthService.signIn('JohnDoe@emails.com', 'FlutterPOC123');
      expect(result, isFalse);
    });

    //4th test for invalid password and email
    test('False for invalid password and email', () async {
      final result = await AuthService.signIn('jesseabuys@emails.com', 'FlutterPOC123');
      expect(result, isFalse);
    });

    //Test for case sensitivity
    test('False when words are correct but not the correct case', () async {
      final result = await AuthService.signIn('JoHnDOe@emAIls.com', 'pASsWorD123!');
      expect(result, isFalse);
    });

    test('True when there are extra spaces in my email', () async {
      final result = await AuthService.signIn('     JohnDoe@emails.com     ', 'Password123!');
      expect(result, isTrue);
    });
    // This should be false

    test('False when empty email', () async {
      final result = await AuthService.signIn('', 'Password123!');
      expect(result, isFalse);
    });

    test('False when empty password', () async {
      final result = await AuthService.signIn('JohnDoe@emails.com', '');
      expect(result, isFalse);
    });    

    // 
    //test('Always false for testing CI/CD', () async {
    //  bool fail = false;
    //  expect(fail, isTrue);
    //});
  });
}