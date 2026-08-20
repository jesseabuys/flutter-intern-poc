import 'package:shared_preferences/shared_preferences.dart';

// User profile class that we use to store, edit, load and update our profile information.
class UserProfile {
  String name;
  String email;
  String number;

  UserProfile({
    this.name = 'John Doe',
    this.email = 'JohnDoe@emails.com',
    this.number = '',
  });

  // Shared preferences are used to store the information
  static Future<void> saveProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', profile.name);
    await prefs.setString('email', profile.email);
    await prefs.setString('number', profile.number);
  }
  
  static Future<UserProfile> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    return UserProfile(
      name: prefs.getString('name') ?? '',
      email: prefs.getString('email') ?? '',
      number: prefs.getString('number') ?? '',
    );
  }

}