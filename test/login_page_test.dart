import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_poc/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:snaptest/snaptest.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the test environment.
  testWidgets('LoginPage logins in correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MyLoginPage(),
        ),
      );

    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'JohnDoe@emails.com',
    );

    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Password123!',
    );

    await tester.pumpAndSettle();
    
    await snap(
      name: 'Information in login',
      settings: SnaptestSettings.rendered(devices: [
        Devices.android.samsungGalaxyS20,
      ]),
    ); // Tap send
    await tester.tap(find.text('Log In'));

    await tester.pumpAndSettle();
    await snap(
      settings: SnaptestSettings.rendered(devices: [
        Devices.android.samsungGalaxyS20,
      ]),
    ); // Tap send
    await tester.pumpAndSettle();
    expect(find.text('Main Menu'), findsOneWidget);
    // Test code goes here.
  });
}