import 'package:flutter/material.dart';
import 'package:flutter_application_poc/services/validation_service.dart';
import 'package:flutter_application_poc/SharedWidgets/white_container.dart';
import 'package:flutter_application_poc/SharedWidgets/message.dart';
import 'package:flutter_application_poc/services/auth_service.dart';
import 'package:flutter_application_poc/screens/main_menu_page.dart';
import 'package:flutter_application_poc/SharedWidgets/gradient_scaffold.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  // Initialise private final attributes for inputting and validating email and password fields.
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Initialise two attributes that keep track of whether to obscure a password or make the login button unpressable
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  Future<void> _handleLogin() async {
    // If our formKey is not validated (.validate() returns false) then we immediately exit the function.
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      // Since we are hardcoding the login we wait two seconds to mimic connecting to a server
      await Future.delayed(const Duration(seconds: 2));
    
      // Call our helper method signIn to validate that the email we are entering is valid
      final success = await AuthService.signIn(
       _emailController.text,
       _passwordController.text,
      );

      // Checks that our widget has not been disposed, if it has we exit the function immediately
      if (!mounted) return;

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
          builder: (context) => const MainMenuPage(),
          ),
        );

      } else {
        Messenger.showMessage(context, 'Invalid email or password.');
      }
    
    // Catch errors
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );

    // If no errors stop loading
    } finally {

      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleBiometricLogin() async {
    setState(() => _isLoading = true);

    try {
      final isLoggedIn = await AuthService.isLoggedIn();

      if (!mounted) return;

      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainMenuPage(),
          ),
        );
      } else {
        Messenger.showMessage(
          context,
          'No saved login found.',
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold( 
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    
                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 12,
                            color: Colors.black26,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.lock,
                        size: 70,
                        color: Colors.indigo,
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                        'Flutter POC',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 48,
                          fontWeight: FontWeight(1000),
                        ),
                    ),
                    const SizedBox(height: 36),
                    
                    //Email field
                    WhiteContainer(
                      child: TextFormField(
                        controller: _emailController,
                        enabled: !_isLoading,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email Address:',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ), 
                        validator: ContactValidator.validateEmail
                      ),
                    ),
                    const SizedBox(height: 18),

                    WhiteContainer(
                      child: TextFormField(
                        controller: _passwordController,
                        enabled: !_isLoading,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password:',
                          prefixIcon: Icon(Icons.lock_clock_outlined),
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                              onPressed: () {
                                setState(() => _obscurePassword = !_obscurePassword);
                              },
                          ),
                        ),    
                      // validator that our form key uses to check if a users input is valid
                          validator: ContactValidator.validatePassword
                      ),
                    ),
                    const SizedBox(height: 18),

                    //Login button
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: _isLoading
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.login),
                      label: Text(
                        _isLoading ? 'Logging in...' : 'Log In',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _handleBiometricLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.fingerprint),
                      label: const Text(
                        'Login with Biometric',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ), 
          ),
        ),
      );
  }
}