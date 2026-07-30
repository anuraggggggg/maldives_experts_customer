import 'package:flutter/material.dart';

abstract final class AppBottomSheet {
  static Future<T?> show<T>(BuildContext context, Widget child) =>
      showModalBottomSheet<T>(context: context, builder: (_) => child);
}
