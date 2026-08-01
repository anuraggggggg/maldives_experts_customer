import 'package:flutter/material.dart';

abstract final class AppBottomSheet {
  static Future<T?> show<T>(
    BuildContext context,
    Widget child, {
    bool isScrollControlled = false,
  }) => showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => child,
  );
}
