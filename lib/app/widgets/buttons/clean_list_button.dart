import 'package:flutter/material.dart';

class CleanListButton extends StatelessWidget {
  const CleanListButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: onPressed,
      color: Colors.white,
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.blue),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
      icon: const Icon(Icons.refresh),
    );
  }
}
