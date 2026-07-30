import 'package:flutter/material.dart';

abstract final class AppDialog {
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
  }) => showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(title: Text(title), content: Text(message)),
  );
}
