import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snaptest/snaptest.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_application_poc/screens/profile_page.dart';

void main() {
  testWidgets('Save button saves details', (tester) async {
    SharedPreferences.setMockInitialValues({});
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
    await tester.pumpAndSettle();
    
        // Scroll to button
    final saveButton = find.text('Save').first;
    
    await tester.ensureVisible(saveButton);
    await tester.pumpAndSettle();

  
    await tester.tap(saveButton);
    await tester.pumpAndSettle();
    
    await snap(
      settings: SnaptestSettings.rendered(devices: [
        Devices.android.samsungGalaxyS20,
      ]),
    ); // Tap send
  });

  testWidgets('Profile page displays correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfilePage(),
      ),
    );
    await snap(
      settings: SnaptestSettings.rendered(devices: [
        Devices.android.samsungGalaxyS20,
      ]),
    ); // Tap send

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