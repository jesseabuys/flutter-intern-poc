import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_poc/screens/family_page.dart';
import 'package:flutter_application_poc/screens/profile_page.dart';

void main() {
  testWidgets('Policy information expands and collapses', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyFamilyPage(),
      ),
    );

    // Initially hidden
    expect(find.text('POL-12345678'), findsNothing);

    // Expand
    await tester.tap(find.text('Policy information'));
    await tester.pumpAndSettle();

    expect(find.text('POL-12345678'), findsOneWidget);
    expect(find.text('Comprehensive Family Cover'), findsOneWidget);
    expect(find.text('Premium Family'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);

    // Collapse
    await tester.tap(find.text('Policy information'));
    await tester.pumpAndSettle();

    expect(find.text('POL-12345678'), findsNothing);
  });

  testWidgets('Contact details displays information', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyFamilyPage(),
      ),
    );
    final expand = find.text('Contact details').first;

    await tester.ensureVisible(expand);
    await tester.pumpAndSettle();
    
    await tester.ensureVisible(expand);

    await tester.tap(expand);
    await tester.pumpAndSettle();

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();

    expect(find.text('John Smith'), findsOneWidget);
    expect(find.text('john.smith@example.com'), findsOneWidget);
    expect(find.text('07123 456 789'), findsOneWidget);
    expect(
      find.text('123 Example Street\nYork\nYO1 1AA'),
      findsOneWidget,
    );
    expect(find.text('Phone'), findsOneWidget);
  });

  testWidgets('Edit button opens Profile Page', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyFamilyPage(),
      ),
    );
    final expand = find.text('Contact details').first;

    await tester.ensureVisible(expand);
    await tester.pumpAndSettle();
    
    await tester.ensureVisible(expand);

    await tester.tap(expand);
    await tester.pumpAndSettle();

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    expect(find.byType(ProfilePage), findsOneWidget);
  });

  testWidgets('Member cards can be horizontally scrolled', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyFamilyPage(),
      ),
    );

    expect(
      find.text('RHUBARB RECORD SUN'),
      findsOneWidget,
    );

    await tester.drag(
      find.text('RHUBARB RECORD SUN'),
      const Offset(-300, 0),
    );

    await tester.pumpAndSettle();

    expect(
      find.text('RHUBARB RECORD MOON'),
      findsOneWidget,
    );
  });

  testWidgets('Claims button navigates to Claims page', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyFamilyPage(),
      ),
    );

    await tester.tap(find.text('Claims'));
    await tester.pumpAndSettle();

    expect(find.byType(ClaimsPage), findsOneWidget);
  });
}