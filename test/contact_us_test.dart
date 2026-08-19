import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snaptest/snaptest.dart';
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
    await tester.pumpAndSettle();
    
    await snap(
      settings: SnaptestSettings.rendered(devices: [
        Devices.android.samsungGalaxyS20
      ]),
    ); // Tap send
    
    await tester.ensureVisible(sendButton);
    await tester.pumpAndSettle();

    // Tap send
    await tester.tap(sendButton);
    await snap(
      settings: SnaptestSettings.rendered(devices: [
        Devices.android.samsungGalaxyS20,
      ]),
    ); // Tap send
    await tester.pumpAndSettle();
    // Add snap
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
    // Add snap
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

  testWidgets('Contact details expansion shows phone number and email', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ContactUsPage(),
      ),
    );

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

    await snap(
      settings: SnaptestSettings.rendered(devices: [
        Devices.android.samsungGalaxyS20,
      ]),
    ); // Tap send
     
  });
}