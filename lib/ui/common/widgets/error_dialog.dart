import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';

class ErrorDialog {
  final String message;
  const ErrorDialog({required this.message});

  static void show(BuildContext context, String message) {
    FrostedDialog.show(
      context: context,
      title: const Text('Erreur'),
      content: Text(message),
      actions: [
        FrostedTextButton(
          foregroundColor: Theme.of(context).colorScheme.error,
          child: const Text('OK'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
