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
              Color.fromARGB(255, 221, 225, 238),
              Color.fromARGB(255, 191, 188, 235),
              Color.fromARGB(255, 180, 146, 236),
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