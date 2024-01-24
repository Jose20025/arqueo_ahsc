import 'package:flutter/material.dart';

class AHSCLogo extends StatelessWidget {
  const AHSCLogo({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'assets/images/logo-ahsc.jpeg',
          isAntiAlias: true,
          semanticLabel: 'Logo AHSC',
          fit: BoxFit.contain,
          height: height,
        ),
      ),
    );
  }
}
