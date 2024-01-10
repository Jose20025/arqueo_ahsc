import 'package:flutter/material.dart';

class AHSCLogo extends StatelessWidget {
  const AHSCLogo({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.asset(
        'assets/images/logo-ahsc.jpeg',
        fit: BoxFit.contain,
        height: height,
      ),
    );
  }
}
