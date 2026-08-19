import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_poc/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // Check slowing down
  testWidgets('Complete app user journey', (tester) async {

    // Start the application
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // LOGIN PAGE
    expect(find.text('Flutter POC'), findsOneWidget);

    // Enter email
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'JohnDoe@emails.com',
    );

    // Enter password
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Password123!',
    );

    await tester.pumpAndSettle();
    
    // Log in
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();
    
    await tester.pumpAndSettle();

    // MAIN MENU

    expect(find.text('Main Menu'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Contact Us'), findsOneWidget);
    expect(find.text('Log Out'), findsOneWidget);

    // PROFILE PAGE

    await tester.tap(find.text('Profile'));
    SharedPreferences.setMockInitialValues({});
    await tester.pumpAndSettle();

    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Your Details'), findsOneWidget);

    // Check profile fields exist
    expect(find.byType(TextFormField), findsNWidgets(3));

    // Change the name
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'John Doe',
    );

    await tester.enterText(
      find.byType(TextFormField).at(1),
      'JohnDoe@emails.com',
    ); 

    await tester.enterText(
      find.byType(TextFormField).at(2),
      '0731515914',
    );
        // Scroll to button
    final saveButton = find.text('Save').first;

    await tester.ensureVisible(saveButton);

    // Tap send
    await tester.tap(saveButton);
    await tester.pump();

    // Return to Main Menu
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Main Menu'), findsOneWidget);

    // CONTACT US PAGE

    await tester.tap(find.text('Contact Us'));
    await tester.pumpAndSettle();

    expect(find.text('Contact Us'), findsOneWidget);
    expect(find.text('Get in touch'), findsOneWidget);
    expect(find.text('Ask Us Anything'), findsOneWidget);

    // Find the expandable contact details widget
    final contactDetails = find.byType(ExpansionTile);

    expect(contactDetails, findsOneWidget);

    // Pull down / expand the widget
    await tester.tap(contactDetails);
    await tester.pumpAndSettle();

    // Check that the phone number is displayed
    expect(
      find.text('+27 73 151 5914'),
      findsOneWidget,
    );

    // Check that the email address is displayed
    expect(
      find.text('jesseabuys@emails.com'),
      findsOneWidget,
    );

    // Fill in name
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'John Doe',
    );

    // Fill in email
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'JohnDoe@email.com',
    );

    // Fill in message
    await tester.enterText(
      find.byType(TextFormField).at(2),
      'This is a test message.',
    );
    
    // Scroll to button
    final sendButton = find.text('Send Message').first;

    await tester.ensureVisible(sendButton);

    // Tap send
    await tester.tap(sendButton);

    await tester.pumpAndSettle();
    
    // Should now be back at Main Menu
    expect(find.text('Main Menu'), findsOneWidget);

    // LOG OUT

    await tester.tap(find.text('Log Out'));
    await tester.pumpAndSettle();

    // Should return to Login
    expect(find.text('Flutter POC'), findsOneWidget);
  });
}