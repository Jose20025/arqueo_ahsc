import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, {required String title}) {
  // Eliminar las snackbar que estén abiertas
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    buildErrorSnackBar(title),
  );
}

SnackBar buildErrorSnackBar(String title) {
  return SnackBar(
    content: Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
    duration: const Duration(milliseconds: 1500),
    dismissDirection: DismissDirection.down,
    showCloseIcon: true,
  );
}
