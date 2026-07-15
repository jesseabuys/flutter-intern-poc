import 'package:flutter/material.dart';
import 'package:flutter_application_poc/services/authservice.dart';
import 'package:flutter_application_poc/screens/MainMenuPage.dart';
import 'package:flutter_application_poc/SharedWidgets/GradientScaffold.dart';

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password.')),
        );
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

                    const Text('Flutter POC',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    const Icon(Icons.lock_outline, size:90, color: Colors.indigo),
                    const SizedBox(height: 18),
                    const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)                    
                    ),
                    const SizedBox(height: 36),
                    
                    //Email field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Address:',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ), 
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),

                    TextFormField(
                      controller: _passwordController,
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
                      // validatopr that our form key uses to check if a users input is valid
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 9),

                    //Login button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                      child: _isLoading 
                            ? const SizedBox(
                              height: 20,
                              width:20,
                              child: CircularProgressIndicator(strokeWidth: 3,
                                    color: Colors.indigo),
                              )
                            : const Text('Log In', style: TextStyle(fontSize:16)),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ), 
          ),
        ),
      );
  }
}