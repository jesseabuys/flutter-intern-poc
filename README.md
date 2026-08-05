This project showcases a simple mobile application built using Flutter.

- User authentication
- Form validation
- Local data persistence using SharedPreferences
- Navigation between multiple screens
- Reusable custom widgets
- Unit and widget testing
- Continuous Integration with GitHub Actions

The project consists of four main screens:

- **Login**
- **Main Menu**
- **Profile**
- **Contact Us**

## Built With

- Flutter
- Dart
- Material Design
- SharedPreferences
- flutter_test
- GitHub Actions


## Getting Started

Follow these instructions to run the project locally.

### Prerequisites

Before running the application, ensure you have installed:

- Flutter SDK
- Dart SDK (included with Flutter)
- Visual Studio Code or Android Studio
- Android Emulator or a physical Android device

Check your Flutter installation:

flutter doctor

### Login

Enter the demo credentials to access the application.

After logging in you can:

- View the Main Menu
- Edit your profile
- Save profile information
- Submit the Contact Us form
- Log out

Profile information is stored locally using SharedPreferences and remains available after restarting the application.

## Testing

The project includes:

- Unit Tests
  - Authentication
  - Validation
  - Profile persistence

- Widget Tests
  - Login Screen
  - Main Menu
  - Profile Page
  - Contact Us Page

## Continuous Integration

GitHub Actions automatically performs the following on every push and pull request:

- Install Flutter dependencies
- Run static analysis
- Execute all unit tests
- Execute all widget tests

When code is merged into the **main** branch:

- Build the application
- Generate an APK
- Upload the APK as a workflow artifact
