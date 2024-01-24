import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.onAccept,
    required this.description,
    this.color,
  });

  final void Function() onAccept;
  final String description;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('¿Estás seguro?'),
      content: Text(description),
      actions: [
        FilledButton.tonal(
          onPressed: () => Navigator.pop(context),
          style: ButtonStyle(
            backgroundColor:
                color != null ? MaterialStateProperty.all(color) : null,
          ),
          child: const Text('Cancelar'),
        ),
        FilledButton.tonal(
          onPressed: () {
            onAccept();
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor:
                color != null ? MaterialStateProperty.all(color) : null,
          ),
          child: const Text('Aceptar'),
        ),
      ],
      surfaceTintColor: color,
    );
  }
}
