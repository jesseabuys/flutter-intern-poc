import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_poc/screens/main_menu_page.dart';
import 'package:flutter_application_poc/screens/login_page.dart';
import 'package:flutter_application_poc/screens/profile_page.dart';
import 'package:flutter_application_poc/screens/contact_us_page.dart';

void main() {
  testWidgets('Main menu navigates to Profile page', (tester) async {

    await tester.pumpWidget(
      const MaterialApp(
        home: MainMenuPage(),
      ),
    );

    // Tap profile button
    await tester.tap(find.text('Profile'));

    await tester.pumpAndSettle();

    // Check profile page opened
    expect(find.text('Profile'), findsOneWidget);

  });


  testWidgets('Main menu navigates to Contact Us page', (tester) async {

    await tester.pumpWidget(
      const MaterialApp(
        home: MainMenuPage(),
      ),
    );

    // Tap contact us button
    await tester.tap(find.text('Contact Us'));

    await tester.pumpAndSettle();

    // Check contact page opened
    expect(find.text('Contact Us'), findsOneWidget);

  });


  testWidgets('Main menu logs out correctly', (tester) async {

    await tester.pumpWidget(
      const MaterialApp(
        home: MainMenuPage(),
      ),
    );

    // Tap logout
    await tester.scrollUntilVisible(
      find.text('Log Out'),
      500,
    );
    
    await tester.tap(find.text('Log Out'));

    await tester.pumpAndSettle();

    // Check we returned to login page
    expect(find.text('Login'), findsOneWidget);

  });

}