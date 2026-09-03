import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_application_poc/main.dart';
import 'package:flutter_application_poc/screens/login_page.dart';
import 'package:flutter_application_poc/screens/profile_page.dart';
import 'package:flutter_application_poc/screens/family_page.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('tests all My Family functionality', (tester) async {

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
     expect(find.byType(MyLoginPage), findsOneWidget);

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

    await tester.tap(find.text('My Family'));
    await tester.pumpAndSettle();
    // MY FAMILY PAGE

    expect(find.text('RHUBARB RECORD SUN'), findsOneWidget);
    expect(find.text('HOLDER'), findsOneWidget);

    expect(find.text('ID number'), findsOneWidget);
    expect(find.text('Birth date'), findsOneWidget);
    expect(find.text('Member number'), findsOneWidget);

    // HORIZONTAL MEMBER CARDS

    final memberCard = find.text('RHUBARB RECORD SUN');

    expect(memberCard, findsOneWidget);

    // Swipe the member card horizontally.
    await tester.drag(
      memberCard,
      const Offset(-300, 0),
    );

    await tester.pumpAndSettle();

    // The second member should now be visible.
    expect(
      find.text('RHUBARB RECORD MOON'),
      findsOneWidget,
    );

    // Swipe back to the first card.
    await tester.drag(
      find.text('RHUBARB RECORD MOON'),
      const Offset(300, 0),
    );

    await tester.pumpAndSettle();

    expect(
      find.text('RHUBARB RECORD SUN'),
      findsOneWidget,
    );

    // CLAIMS

    await tester.tap(find.text('Claims'));
    await tester.pumpAndSettle();
    expect(find.byType(ClaimsPage), findsOneWidget);
    
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('RHUBARB RECORD SUN'), findsOneWidget);

    // BENEFITS

    await tester.tap(find.text('Benefits'));
    await tester.pumpAndSettle();

    expect(find.byType(BenefitsPage), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    // AUTHORISATIONS

    await tester.tap(find.text('Authorisations'));
    await tester.pumpAndSettle();

    expect(find.byType(AuthorisationsPage), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    // SETTINGS

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsPage), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    // POLICY INFORMATION

    // Initially the information should be collapsed.
    expect(
      find.text('POL-12345678'),
      findsNothing,
    );

    await tester.tap(find.text('Policy information'));
    await tester.pumpAndSettle();

    // Check that the contents appeared.
    expect(
      find.text('POL-12345678'),
      findsOneWidget,
    );

    expect(
      find.text('Comprehensive Family Cover'),
      findsOneWidget,
    );

    expect(
      find.text('01 January 2026'),
      findsOneWidget,
    );

    expect(
      find.text('01 January 2027'),
      findsOneWidget,
    );

    expect(
      find.text('Premium Family'),
      findsOneWidget,
    );

    expect(
      find.text('Active'),
      findsOneWidget,
    );

    // Collapse it again.
    await tester.tap(find.text('Policy information'));
    await tester.pumpAndSettle();

    expect(
      find.text('POL-12345678'),
      findsNothing,
    );

    // CONTACT DETAILS

    await tester.tap(find.text('Contact details'));
    await tester.pumpAndSettle();

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -500),
    );

    await tester.pumpAndSettle();

    expect(
      find.text('John Smith'),
      findsOneWidget,
    );

    expect(
      find.text('john.smith@example.com'),
      findsOneWidget,
    );

    expect(
      find.text('07123 456 789'),
      findsOneWidget,
    );

    expect(
      find.text('123 Example Street\nYork\nYO1 1AA'),
      findsOneWidget,
    );

    expect(
      find.text('Email'),
      findsOneWidget,
    );

    // EDIT PROFILE

    expect(
      find.text('Edit'),
      findsOneWidget,
    );

    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    // Check that the profile page opened.
    expect(
      find.byType(ProfilePage),
      findsOneWidget,
    );

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(
      find.text('Contact details'),
      findsOneWidget,
    );

    await tester.tap(find.text('Contact details'));
    await tester.pumpAndSettle();

    // BANK DETAILS

    await tester.tap(find.text('Bank details'));
    await tester.pumpAndSettle();

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -500),
    );
    
    expect(
      find.text('John Smith'),
      findsOneWidget,
    );

    expect(
      find.text('Example Bank'),
      findsOneWidget,
    );

    expect(
      find.text('12-34-56'),
      findsOneWidget,
    );

    expect(
      find.text('•••• 6789'),
      findsOneWidget,
    );

    expect(
      find.text('Direct Debit'),
      findsOneWidget,
    );

    // Collapse it again.
    await tester.tap(find.text('Bank details'));
    await tester.pumpAndSettle();

    expect(
      find.text('Example Bank'),
      findsNothing,
    );

    // BOTTOM NAVIGATION

    // Home
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    // Member card
    await tester.tap(find.text('Member\ncard'));
    await tester.pumpAndSettle();

    // Menu
    await tester.tap(find.text('Menu'));
    await tester.pumpAndSettle();

    // Contact us
    await tester.tap(find.text('Contact\nus'));
    await tester.pumpAndSettle();

    // My family
    await tester.tap(find.text('My\nfamily'));
    await tester.pumpAndSettle();

    // FINAL CHECK

    expect(
      find.text('RHUBARB RECORD SUN'),
      findsOneWidget,
    );

    expect(
      find.text('Policy information'),
      findsOneWidget,
    );

    expect(
      find.text('Contact details'),
      findsOneWidget,
    );

    expect(
      find.text('Bank details'),
      findsOneWidget,
    );
  });
}
