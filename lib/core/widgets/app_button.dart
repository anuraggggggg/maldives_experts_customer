import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.gradient,
    this.borderRadius = AppSpacing.radiusSm,
    this.enableHaptics = true,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final Gradient? gradient;
  final double borderRadius;
  final bool enableHaptics;

  void _handlePressed() {
    if (enableHaptics) HapticFeedback.lightImpact();
    onPressed?.call();
  }

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      gradient: onPressed == null
          ? const LinearGradient(
              colors: [AppColors.disabled, AppColors.disabled],
            )
          : gradient,
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: SizedBox(
      height: AppSpacing.controlHeight,
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed == null ? null : _handlePressed,
        style: FilledButton.styleFrom(
          backgroundColor: gradient == null
              ? AppColors.authBlue
              : AppColors.transparent,
          disabledBackgroundColor: gradient == null
              ? AppColors.disabled
              : AppColors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(label, style: AppTextStyles.button),
                  if (icon case final icon?) ...[
                    const SizedBox(width: AppSpacing.sm),
                    Icon(icon, color: AppColors.white, size: 18),
                  ],
                ],
              ),
      ),
    ),
  );
}
