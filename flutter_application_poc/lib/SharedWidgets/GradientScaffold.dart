import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;

  const GradientScaffold({
    super.key,
    required this.child,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 240, 241, 245),
              Color.fromARGB(255, 209, 207, 239),
              Color.fromARGB(255, 199, 176, 237),
            ],
          ),
        ),
        child: SafeArea(
          child: child,
        ),
      ),
    );
  }
}