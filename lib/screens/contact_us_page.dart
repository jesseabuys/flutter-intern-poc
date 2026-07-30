import 'package:flutter/material.dart';
import 'package:flutter_application_poc/services/validation_service.dart';
import 'package:flutter_application_poc/SharedWidgets/gradient_scaffold.dart';
import 'package:flutter_application_poc/SharedWidgets/white_container.dart';
import 'package:flutter_application_poc/screens/main_menu_page.dart';

// Page containing our details as well as some text forms that a user can fill in to send a message.
class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  // Controllers for our forms
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final ExpansibleController controller = ExpansibleController();

  // Keeps track of whether the user has pressed the send message button.
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // Method for when we send a message.
  Future<void> _handleSend() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    try {
      await Future.delayed(const Duration(seconds: 2));
      //Mounting checking to see if anything is out of place
      if (!mounted) return;
      //await Future.delayed(const Duration(seconds: 1));
      //Messenger.showMessage(context, "Message received. We'll get back to you soon.");
      //await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainMenuPage(),
        ),
      );

      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

@override
  Widget build(BuildContext context) {
    return GradientScaffold(
        appBar: AppBar(title: const Text('Contact Us')), 
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

                   Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 8,
                          offset: Offset(0, 4),
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    child: const Text(
                      'Get in touch',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
                    
                    const SizedBox(height: 32),

                    ExpansionTile(
                      controller: controller,
                      title: 
                      const Text('Our Details', 
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                      ),

                      children: [
                        Container(
                          alignment: .center,
                          padding: const .all(24),
                          child: const Column(
                          mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Phone: +27 73 151 5914',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Email: jesseabuys@emails.com',
                                style: TextStyle(fontSize: 18),
                              )
                            ]
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    const Text(
                      'Ask Us Anything',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)                    
                    ),
                    const SizedBox(height: 36),
                    
                    WhiteContainer(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Your Name:',
                          prefixIcon: Icon(Icons.person_3_outlined),

                        ), 
                        validator: ContactValidator.validateName
                      ),
                    ),
                    const SizedBox(height: 18),

                    WhiteContainer(
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email Address:',
                          prefixIcon: Icon(Icons.email_outlined),

                        ), 
                        validator: ContactValidator.validateEmail
                      ),
                    ),
                    const SizedBox(height: 18),

                    WhiteContainer(
                      child: TextFormField(
                        controller: _messageController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'Your Message:',
                          prefixIcon: Icon(Icons.message),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.all(16),
                        ), 
                        // validator that our form key uses to check if a users input is valid
                        validator: ContactValidator.validateMessage
                      ),
                    ),
                    const SizedBox(height: 9),

                    //Login button
                    ElevatedButton(
                      onPressed: _isSending ? null : _handleSend,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                      child: _isSending 
                            ? const SizedBox(
                              height: 20,
                              width:20,
                              child: CircularProgressIndicator(strokeWidth: 3,
                                    color: Colors.indigo),
                              )
                            : const Text('Send Message', style: TextStyle(fontSize:16)),
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



