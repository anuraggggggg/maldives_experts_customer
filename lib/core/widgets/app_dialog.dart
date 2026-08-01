import 'package:flutter/material.dart';

abstract final class AppDialog {
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) => showAdaptiveDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('OK'),
        ),
        if (actionLabel != null)
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onAction?.call();
            },
            child: Text(actionLabel),
          ),
      ],
    ),
  );
}
