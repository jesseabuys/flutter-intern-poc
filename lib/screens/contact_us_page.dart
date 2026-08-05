import 'package:flutter/material.dart';
import 'package:flutter_application_poc/services/validation_service.dart';
import 'package:flutter_application_poc/SharedWidgets/gradient_scaffold.dart';
import 'package:flutter_application_poc/SharedWidgets/white_container.dart';
import 'package:flutter_application_poc/screens/main_menu_page.dart';
import 'package:flutter_application_poc/SharedWidgets/message.dart';

// Logic and UI for contact us screen on the flutter POC application. 
class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  // Form keys for validating input
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final ExpansibleController controller = ExpansibleController();

  bool _isSending = false;

  static const _accent = Colors.indigo;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    try {
      // Mimic wait time for sending a message 
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Messenger.showMessage(context, "Message received. We'll get back to you soon.");
      // Takes you back to main menu
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainMenuPage()),
      );

      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    } catch (e) {
      // Mounting check to make sure thatwe have no errors
      if (!mounted) return;
      Messenger.showMessage(context,'Failed to send: $e');
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  // Transparent decoration is used since WhiteContainer already provides the background, radius and shadow, 
  // so the field itself shouldn't
  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: _accent),
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    );
  }

  Widget _contactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: _accent),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(title: const Text('Contact Us')),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WhiteContainer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.mail_outline, size: 32, color: Colors.indigo),
                          SizedBox(width: 12),
                          Text(
                            'Get in touch',
                            
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.indigo,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  WhiteContainer(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: ExpansionTile(
                        controller: controller,
                        title: const Text(
                          'Our Details',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _contactRow(Icons.phone_outlined, '+27 73 151 5914'),
                                _contactRow(Icons.email_outlined, 'jesseabuys@emails.com'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                  const Text(
                    'Ask Us Anything',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  WhiteContainer(
                    child: TextFormField(
                      controller: _nameController,
                      decoration: _decoration('Your Name', Icons.person_outline),
                      validator: ContactValidator.validateName,
                    ),
                  ),
                  const SizedBox(height: 16),

                  WhiteContainer(
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _decoration('Email Address', Icons.email_outlined),
                      validator: ContactValidator.validateEmail,
                    ),
                  ),
                  const SizedBox(height: 16),

                  WhiteContainer(
                    child: TextFormField(
                      controller: _messageController,
                      maxLines: 5,
                      decoration: _decoration('Your Message', Icons.message_outlined)
                          .copyWith(alignLabelWithHint: true),
                      validator: ContactValidator.validateMessage,
                    ),
                  ),
                  const SizedBox(height: 24),

                  ElevatedButton.icon(
                    onPressed: _isSending ? null : _handleSend,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: _isSending
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send),
                    label: Text(
                      _isSending ? 'Sending...' : 'Send Message',
                      style: const TextStyle(fontSize: 16),
                    ),
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