This project showcases a simple mobile application built using Flutter.

- User authentication
- Form validation
- Local data persistence using SharedPreferences
- Navigation between multiple screens
- Reusable custom widgets
- Additional Family screen with navigation and interactive features
- Integration testing across the application
- Screenshot capture on test failure
- Unit and widget testing
- Continuous Integration with GitHub Actions

The project consists of four main screens:

- **Login**
- **Main Menu**
- **Profile**
- **Contact Us**
- **My Family**
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

### Screens

The application consists of five main screens:

- **Login** – Allows users to authenticate and access the application using the demo credentials.
- **Main Menu** – Provides navigation to the different areas of the application.
- **Profile** – Allows users to view, edit and save their profile information. Profile information is stored locally using SharedPreferences and remains available after restarting the application.
- **Contact Us** – Allows users to submit a message through the Contact Us form.
- **Family** – Provides additional functionality including expansion tiles, action buttons and navigation to other areas of the application.

After logging in, users can navigate between the different screens using the application's navigation.

The screens are supported by unit, widget and integration tests to verify their functionality and navigation.

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
  - Invalid login behaviour
  - Profile expansion tiles and navigation
  - Contact Us functionality
  - Family screen expansion tiles
  - Family screen action buttons
  - Family screen navigation

- Integration Tests
  - Full application user journey
  - Login through to the main application
  - Navigation between application screens
  - Family screen navigation

- Screenshot Testing
  - Screenshots captured when integration tests fail
  - Screenshot testing for UI states
  - Testing scrolling behaviour

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

APK builds are also assigned a build number to make different versions of the application easier to identify.

### Test Failure Screenshots

The integration testing setup also includes screenshot capture when a test fails. This allows the state of the application at the point of failure to be inspected, making it easier to identify and troubleshoot UI and navigation issues.