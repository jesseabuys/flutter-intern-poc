import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_poc/screens/profile_page.dart';

void main() {
  testWidgets('Save button saves details', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfilePage(),
      ),
    );

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

  });

    testWidgets('Profile page displays correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfilePage(),
      ),
    );

    // Check page title
    expect(find.text('Profile'), findsOneWidget);

    // Check profile picture exists
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Check text fields exist
    expect(find.byType(TextFormField), findsNWidgets(3));

    // Check save button exists
    expect(find.text('Save'), findsOneWidget);
  });

}