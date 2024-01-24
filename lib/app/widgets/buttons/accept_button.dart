import 'package:flutter/material.dart';

class AcceptButton extends StatelessWidget {
  const AcceptButton({super.key, required this.onPressed, required this.text});

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton.tonal(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
