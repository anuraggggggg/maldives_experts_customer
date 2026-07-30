import 'package:flutter/material.dart';

import '../constants/app_strings.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    required this.onRetry,
    this.message = AppStrings.genericError,
    super.key,
  });

  final VoidCallback onRetry;
  final String message;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message),
        TextButton(onPressed: onRetry, child: const Text(AppStrings.tryAgain)),
      ],
    ),
  );
}
