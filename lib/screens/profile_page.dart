import 'package:flutter/material.dart';
import 'package:flutter_application_poc/SharedWidgets/gradient_scaffold.dart';
import 'package:flutter_application_poc/services/user_profile.dart';
import 'package:flutter_application_poc/SharedWidgets/white_container.dart';

// Profile screen for our app that contains three editable text fields and uses shared preferences to save the
// user information.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

// Since we are not validating any user information I did not use a form key(Maybe should have)
class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProfile();
  }
  
  // We dispose controllers when we are done with the screen

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  // Load the profile from our UserProfile class and set the values of name, email and number to 
  // those values if they are already contained in our shared preferences.
  Future<void> loadProfile() async {
    UserProfile profile = await UserProfile.loadProfile();

    setState(() {
      _nameController.text = profile.name;
      _emailController.text = profile.email;
      _numberController.text = profile.number;
    });
  }

  // If we make changes to any of the fields and press the save button then the profile is 
  // updated with what is in our text controllers.
  Future<void> saveProfile() async {
    UserProfile profile = UserProfile(
      name: _nameController.text,
      email: _emailController.text,
      number: _numberController.text,
    );

    // Check mount and create method ....
    await UserProfile.saveProfile(profile);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile Saved")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            const CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('lib/assets/proficon.jpg'),
            ),

            const SizedBox(height: 40),

        // Welcome message
            Text(
              'Your Details',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 50),
      
            WhiteContainer(
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name:',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ), 

            const SizedBox(height: 30),

            WhiteContainer(
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email:',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ), 

            const SizedBox(height: 30),

            WhiteContainer(
              child: TextFormField(
                controller: _numberController,
                decoration: const InputDecoration(
                  labelText: 'Number:',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
            ), 

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: saveProfile,
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}