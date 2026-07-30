
import 'package:test/test.dart';
import 'package:flutter_application_poc/services/validation_service.dart';

//Class containing unit tests for validation service
void main() {
  group('Test start, valid message, invalid email, one or more fields empty.', () {
    // 1st test is checking the hardcoded credentials work 
    test('Empty name returns error', () {
      expect(
        ContactValidator.validateName(''),
        'Please enter your name.',
      );
    });

    test('Valid name returns null', () {
      expect(
        ContactValidator.validateName('Jesse'),
        null,
      );
    });

    test('Invalid email returns error', () {
      expect(
        ContactValidator.validateEmail('hello'),
        'Please enter a valid email.',
      );
    });

    test('Valid email returns null', () {
      expect(
        ContactValidator.validateEmail('JohnDoe@emails.com'),
        null,
      );
    });

    test('Empty message returns error', () {
      expect(
        ContactValidator.validateMessage(''),
        'Please enter your message.',
      );
    });

        test('Invalid password returns error', () {
      expect(
        ContactValidator.validatePassword('pass'),
        'Please enter a valid password.',
      );
    });

    test('Valid password returns null', () {
      expect(
        ContactValidator.validatePassword('Password123!'),
        null,
      );
    });

  });
}