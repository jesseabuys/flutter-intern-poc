import 'package:flutter/material.dart';

// Class that creates a container with a shadow that is used for our text boxes
class WhiteContainer extends StatelessWidget {
  final Widget child;

  const WhiteContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.7),
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}