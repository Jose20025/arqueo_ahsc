import 'package:flutter/material.dart';

class DetailsButton extends StatelessWidget {
  const DetailsButton({super.key, required this.onPressed});

  final void Function() onPressed;

  final buttonStyle = const ButtonStyle(
      // backgroundColor: MaterialStateProperty.all(Colors.blue),
      );

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: const Text(
        'Ver detalles',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
