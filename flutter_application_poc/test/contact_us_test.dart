import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_poc/screens/contact_us_page.dart';

void main() {

  testWidgets('User can send a valid message', (tester) async {

    await tester.pumpWidget(
      const MaterialApp(
        home: ContactUsPage(),
      ),
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
    expect(find.text('Main Menu'), findsOneWidget);


  });

    testWidgets('Empty contact form shows validation errors', (tester) async {

    await tester.pumpWidget(
      const MaterialApp(
        home: ContactUsPage(),
      ),
    );

    // Press send without entering anything
    final sendButton = find.text('Send Message').first;

    await tester.ensureVisible(sendButton);
    await tester.tap(sendButton);

    await tester.pump();

    // Check validators
    expect(
      find.text('Please enter your name.'),
      findsOneWidget,
    );

    expect(
      find.text('Please enter your email address.'),
      findsOneWidget,
    );

    expect(
      find.text('Please enter your message.'),
      findsOneWidget,
    );

  });

}