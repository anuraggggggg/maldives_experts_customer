import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.regular),
    child: Row(
      children: [
        Expanded(child: Text(title, style: AppTextStyles.dashboardSection)),
        if (actionLabel case final label?)
          TextButton.icon(
            onPressed: onAction,
            iconAlignment: IconAlignment.end,
            label: Text(
              label,
              style: const TextStyle(
                color: AppColors.dashboardBlue,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            icon: const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.dashboardBlue,
              size: 19,
            ),
          ),
      ],
    ),
  );
}
