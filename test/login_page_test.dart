import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_poc/screens/login_page.dart';
import 'package:flutter_application_poc/screens/main_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:snaptest/snaptest.dart';

void main() {
  testWidgets('LoginPage logins in correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const MyLoginPage(),
      ),
    );

    // Let any initial animations/frames settle before interacting.
    await tester.pumpAndSettle();

    // Fill in a valid email address.
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'JohnDoe@emails.com',
    );

    // Fill in a valid password.
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Password123!',
    );

    await tester.pumpAndSettle();

    // Snapshot the form after entering valid credentials, before submitting.
    await snap(
      name: 'Information in login',
      settings: SnaptestSettings.rendered(
        devices: [
          Devices.android.samsungGalaxyS20,
        ],
      ),
    );

    // Tap the "Log In" button to submit the form.
    await tester.tap(find.text('Log In'));

    // Wait for navigation and animations to finish.
    await tester.pumpAndSettle();

    // Snapshot the resulting screen after a successful login attempt.
    await snap(
      settings: SnaptestSettings.rendered(
        devices: [
          Devices.android.samsungGalaxyS20,
          // Devices.ios.iPhone16,
        ],
      ),
    );

    // Verify that the MainMenuPage has been loaded.
    expect(find.byType(MainMenuPage), findsOneWidget);
  });

  testWidgets(
    'LoginPage shows an error with invalid information',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const MyLoginPage(),
        ),
      );

      await tester.pumpAndSettle();

      // Enter a malformed email address.
      await tester.enterText(
        find.byType(TextFormField).at(0),
        'JohnDoe@emaoils.com',
      );

      // Enter an invalid password.
      await tester.enterText(
        find.byType(TextFormField).at(1),
        'Passward123!',
      );

      await tester.pumpAndSettle();

      // Snapshot the form showing invalid input before submitting.
      await snap(
        name: 'Invalid information in login',
        settings: SnaptestSettings.rendered(
          devices: [
            Devices.android.samsungGalaxyS20,
          ],
        ),
      );

      // Attempt to submit with invalid credentials.
      await tester.tap(find.text('Log In'));

      await tester.pumpAndSettle();

      // Snapshot the error state after the failed submission attempt.
      await snap(
        name: 'Login error state',
        settings: SnaptestSettings.rendered(
          devices: [
            Devices.android.samsungGalaxyS20,
          ],
        ),
      );

      // Verify that the MainMenuPage was not loaded.
      expect(find.byType(MainMenuPage), findsNothing);

      // Verify a validation/error message is shown instead.
      expect(find.textContaining('Invalid'), findsWidgets);
    },
  );
}