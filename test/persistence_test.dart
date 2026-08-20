import 'package:flutter_application_poc/services/persistence_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

//Class containing unit tests for authentication, validation and persistence service
void main() {
  group('Test start, ', () {

    test('Profile persists after simulated restart', () async {
      SharedPreferences.setMockInitialValues({});

      final profile = UserProfile(
        name: 'John Doe',
        email: 'JohnDoe@emails.com',
        number: '0731515914',
      );

      await UserProfile.saveProfile(profile);

      // Simulate a fresh app launch
      final restartedProfile = await UserProfile.loadProfile();

      expect(restartedProfile.name, 'John Doe');
      expect(restartedProfile.email, 'JohnDoe@emails.com');
      expect(restartedProfile.number, '0731515914');
    });

    test('Profile with nothing in it', () async {

      SharedPreferences.setMockInitialValues({});
      
      final restartedProfile = await UserProfile.loadProfile();

      expect(restartedProfile.name, '');
      expect(restartedProfile.email, '');
      expect(restartedProfile.number, '');
    });

    test('Saving a new profile overwrites the old profile', () async {
      SharedPreferences.setMockInitialValues({});

      await UserProfile.saveProfile(
        UserProfile(
          name: 'John Doe',
          email: 'JohnDoe@emails.com',
          number: '772288331',
        ),
      );

      await UserProfile.saveProfile(
        UserProfile(
          name: 'Jesse Buys',
          email: 'Jesseabuys@test.com',
          number: '0731515914',
        ),
      );

      final profile = await UserProfile.loadProfile();

      expect(profile.name, 'Jesse Buys');
      expect(profile.email, 'Jesseabuys@test.com');
      expect(profile.number, '0731515914');
    });

    test('Updating only one field', () async {
      SharedPreferences.setMockInitialValues({});

      final profile = UserProfile(
        name: 'John Doe',
        email: 'JohnDoe@emails.com',
        number: '0731515914',
      );
      await UserProfile.saveProfile(profile);

      await UserProfile.saveProfile(UserProfile(
          name: profile.name,
          email: 'jesseabuys@emails.com',
          number: profile.number,
        ));

      final updated = await UserProfile.loadProfile();

      expect(updated.name, 'John Doe');
      expect(updated.email, 'jesseabuys@emails.com');
      expect(updated.number, '0731515914');
    });
  });
}