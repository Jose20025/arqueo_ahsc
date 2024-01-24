import 'package:flutter/material.dart';

class CleanListButton extends StatelessWidget {
  const CleanListButton({
    super.key,
    required this.onPressed,
    this.color,
    this.iconColor,
  });

  final void Function() onPressed;
  final Color? color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: onPressed,
      color: iconColor,
      style: ButtonStyle(
        backgroundColor: color != null ? MaterialStatePropertyAll(color) : null,
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
      icon: const Icon(Icons.refresh),
    );
  }
}
