import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) => SearchBar(
    controller: controller,
    hintText: hintText,
    onChanged: onChanged,
    onSubmitted: onSubmitted,
    leading: const Icon(Icons.search, color: AppColors.inputIcon),
    trailing: [
      if (onClear != null)
        IconButton(
          onPressed: onClear,
          icon: const Icon(Icons.close, color: AppColors.inputIcon),
        ),
    ],
    elevation: const WidgetStatePropertyAll(0),
    backgroundColor: const WidgetStatePropertyAll(AppColors.authFieldFill),
    side: const WidgetStatePropertyAll(BorderSide(color: AppColors.divider)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
    ),
  );
}
