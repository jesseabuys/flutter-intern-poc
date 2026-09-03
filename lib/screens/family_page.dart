import 'package:flutter/material.dart';
import 'package:flutter_application_poc/screens/main_menu_page.dart';
import 'package:flutter_application_poc/screens/profile_page.dart';
import 'package:flutter_application_poc/screens/contact_us_page.dart';

class MyFamilyPage extends StatefulWidget {
  const MyFamilyPage({super.key});

  @override
  State<MyFamilyPage> createState() => _MyFamilyPageState();
}

class _MyFamilyPageState extends State<MyFamilyPage> {
  int _selectedNavIndex = 4;

  static const Color darkBlue = Color(0xFF005A78);
  static const Color limeGreen = Color(0xFFC4D600);
  static const Color lightGrey = Color(0xFFD0D7DC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F8),

      appBar: AppBar(
        backgroundColor: darkBlue,
        elevation: 2,
        toolbarHeight: 58,
        automaticallyImplyLeading: false,
        title: const Text(
          'M',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
          child: Column(
            children: [
              // ------------------------------------------------------------
              // TOP HORIZONTAL MEMBER CARD
              // ------------------------------------------------------------
              SizedBox(
                height: 204,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildMemberCard(
                      name: 'RHUBARB RECORD SUN',
                      holder: 'HOLDER',
                      idNumber: '123456789',
                      birthDate: '12/04/2000',
                      memberNumber: '987654321',
                    ),

                    // Example second card. Remove this if you only
                    // want one card.
                    _buildMemberCard(
                      name: 'RHUBARB RECORD MOON',
                      holder: 'DEPENDANT',
                      idNumber: '987654321',
                      birthDate: '24/09/2002',
                      memberNumber: '123456789',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ------------------------------------------------------------
              // FOUR ACTION BUTTONS
              // ------------------------------------------------------------
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.note_add_outlined,
                      label: 'Claims',
                      page: const ClaimsPage(),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.volunteer_activism_outlined,
                      label: 'Benefits',
                      page: const BenefitsPage(),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.verified_user_outlined,
                      label: 'Authorisations',
                      page: const AuthorisationsPage(),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.settings_outlined,
                      label: 'Settings',
                      page: const SettingsPage(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ------------------------------------------------------------
              // EXPANSION TILES
              // ------------------------------------------------------------
              _buildExpansionTile(
                title: 'Policy information',
                children: [
                  _buildInfoRow(
                    'Policy number',
                    'POL-12345678',
                  ),
                  _buildInfoRow(
                    'Policy type',
                    'Comprehensive Family Cover',
                  ),
                  _buildInfoRow(
                    'Start date',
                    '01 January 2026',
                  ),
                  _buildInfoRow(
                    'Renewal date',
                    '01 January 2027',
                  ),
                  _buildInfoRow(
                    'Plan',
                    'Premium Family',
                  ),
                  _buildInfoRow(
                    'Status',
                    'Active',
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _buildExpansionTile(
                title: 'Contact details',
                children: [
                  _buildInfoRow(
                    'Full name',
                    'John Smith',
                  ),
                  _buildInfoRow(
                    'Email',
                    'john.smith@example.com',
                  ),
                  _buildInfoRow(
                    'Mobile number',
                    '07123 456 789',
                  ),
                  _buildInfoRow(
                    'Address',
                    '123 Example Street\nYork\nYO1 1AA',
                  ),
                  _buildInfoRow(
                    'Preferred contact',
                    'Phone',
                  ),

                  const SizedBox(height: 10),

                  // Edit button
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 18,
                      ),
                      label: const Text('Edit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _buildExpansionTile(
                title: 'Bank details',
                children: [
                  _buildInfoRow(
                    'Account holder',
                    'John Smith',
                  ),
                  _buildInfoRow(
                    'Bank',
                    'Example Bank',
                  ),
                  _buildInfoRow(
                    'Sort code',
                    '12-34-56',
                  ),
                  _buildInfoRow(
                    'Account number',
                    '•••• 6789',
                  ),
                  _buildInfoRow(
                    'Payment method',
                    'Direct Debit',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // --------------------------------------------------------------
      // BOTTOM NAVIGATION
      // --------------------------------------------------------------
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // ==================================================================
  // MEMBER CARD
  // ==================================================================

  Widget _buildMemberCard({
    required String name,
    required String holder,
    required String idNumber,
    required String birthDate,
    required String memberNumber,
  }) {
    return Container(
      width: 399,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: limeGreen,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT SIDE
            SizedBox(
              width: 177,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 79,
                        height: 79,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Stack(
                          children: [
                            const Center(
                              child: Icon(
                                Icons.person_outline,
                                size: 55,
                                color: Colors.grey,
                              ),
                            ),
                            Positioned(
                              right: 5,
                              bottom: 4,
                              child: Icon(
                                Icons.edit,
                                size: 18,
                                color: Colors.lightBlue.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 28),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      holder,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // RIGHT SIDE
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCardField(
                    label: 'ID number',
                    value: idNumber,
                  ),

                  const SizedBox(height: 18),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _buildCardField(
                          label: 'Birth date',
                          value: birthDate,
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 34,
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  _buildCardField(
                    label: 'Member number',
                    value: memberNumber,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardField({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 17,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  // ==================================================================
  // ACTION BUTTONS
  // ==================================================================

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Widget page,
  }) {
    return SizedBox(
      height: 77,
      child: Material(
        color: darkBlue,
        borderRadius: BorderRadius.circular(6),
        elevation: 3,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => page,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 9,
              horizontal: 3,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 31,
                ),
                const SizedBox(height: 5),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==================================================================
  // EXPANSION TILE
  // ==================================================================

  Widget _buildExpansionTile({
    required String title,
    required List<Widget> children,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.only(
            left: 0,
            right: 12,
          ),
          childrenPadding: const EdgeInsets.fromLTRB(
            18,
            0,
            18,
            16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          iconColor: darkBlue,
          collapsedIconColor: darkBlue,
          title: Row(
            children: [
              Container(
                width: 17,
                height: 64,
                decoration: const BoxDecoration(
                  color: limeGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: darkBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          children: children,
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                color: darkBlue,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================================================================
  // BOTTOM NAVIGATION
  // ==================================================================

  Widget _buildBottomNavigation() {
    return Container(
      height: 88,
      color: darkBlue,
      child: Row(
        children: [
          _buildNavItem(
            icon: Icons.chat_bubble_outline,
            label: 'Contact\nus',
            index: 0,
          ),
          _buildNavItem(
            icon: Icons.auto_awesome,
            label: 'Main\nmenu',
            index: 1,
            largeIcon: true,
          ),
          _buildNavItem(
            icon: Icons.person_outline,
            label: 'My\nfamily',
            index: 2,
          ),
        ],
      ),
    );
  }
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    bool largeIcon = false,
  }) {
    final bool selected = _selectedNavIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedNavIndex = index;
          });

          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainMenuPage(),
                ),
              );
              break;

            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactUsPage(),
                ),
              );
              break;

            case 2:
              // Already on My Family
              break;
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 3,
          ),
          decoration: selected
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                )
              : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: largeIcon ? 32 : 26,
                color: selected ? darkBlue : Colors.white,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selected ? darkBlue : Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================================================================
// DESTINATION PAGES
// ======================================================================

class ClaimsPage extends StatelessWidget {
  const ClaimsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleDestinationPage(
      title: 'Claims',
      icon: Icons.note_add_outlined,
      description: 'View and manage your claims.',
    );
  }
}

class BenefitsPage extends StatelessWidget {
  const BenefitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleDestinationPage(
      title: 'Benefits',
      icon: Icons.volunteer_activism_outlined,
      description: 'View the benefits available on your policy.',
    );
  }
}

class AuthorisationsPage extends StatelessWidget {
  const AuthorisationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleDestinationPage(
      title: 'Authorisations',
      icon: Icons.verified_user_outlined,
      description: 'View and manage your authorisations.',
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleDestinationPage(
      title: 'Settings',
      icon: Icons.settings_outlined,
      description: 'Manage your application settings.',
    );
  }
}

// ======================================================================
// TEMPORARY DESTINATION SCREEN
// ======================================================================

class SimpleDestinationPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;

  const SimpleDestinationPage({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF005A78);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        foregroundColor: Colors.white,
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 70,
                color: darkBlue,
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}