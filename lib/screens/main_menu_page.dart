import 'package:flutter/material.dart';
import 'package:flutter_application_poc/screens/login_page.dart';
import 'package:flutter_application_poc/screens/profile_page.dart';
import 'package:flutter_application_poc/screens/contact_us_page.dart';
import 'package:flutter_application_poc/SharedWidgets/gradient_scaffold.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

@override
Widget build(BuildContext context) {
  return GradientScaffold(
    appBar: AppBar(
      title: const Text('Main Menu'),
    ),
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            Center(
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('lib/assets/proficon.jpg'),
              ),
            ),
            const SizedBox(height: 25),

          // Welcome message
            const Text(
              'Welcome, John Doe',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 50),

            _MenuCard(
              icon: Icons.person,
              label: 'Profile',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              description: 'View and make changes to your profile.',
            ),

            const SizedBox(height: 24),

            _MenuCard(
              icon: Icons.contact_mail,
              label: 'Contact Us',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUsPage(),
                  ),
                );
              },
              description: 'Get in touch with us.',
            ),

            const SizedBox(height: 24),
            
            _MenuCard(
              icon: Icons.login,
              label: 'Log Out',
              onTap: () => _handleLogout(context),
              description: 'Exit the app.',
            ),

          ],
        ),
      ),
    ),
  );
}

  Future<void> _handleLogout(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MyLoginPage()),
      (route) => false,
    );
  }
}

// Helper class created for displaying the different screens we can go to from the main menu.
// Each menu card has an icon label description and can be tapped.
class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String description;

  const _MenuCard({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.description,

  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),

            Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            const SizedBox(height: 20),

            Text(label, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8),

            Text(description,textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
            const SizedBox(height: 10),

            const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.black54,
            ),
            
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
