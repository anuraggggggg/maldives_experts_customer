import 'package:flutter/material.dart';

import 'app_colors.dart';

/// The app-wide type scale. Screen-specific styles should be derived with
/// [TextStyle.copyWith] so size, rhythm, and weight remain consistent.
abstract final class AppTextStyles {
  static const display = TextStyle(
    fontSize: 32,
    height: 1.16,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );
  static const headline = TextStyle(
    fontSize: 24,
    height: 1.22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
  );
  static const title = TextStyle(
    fontSize: 18,
    height: 1.3,
    fontWeight: FontWeight.w600,
  );
  static const sectionTitle = TextStyle(
    fontSize: 20,
    height: 1.28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
  );
  static const body = TextStyle(fontSize: 16, height: 1.5);
  static const bodyMedium = TextStyle(fontSize: 14, height: 1.45);
  static const label = TextStyle(
    fontSize: 14,
    height: 1.3,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );
  static const caption = TextStyle(
    fontSize: 12,
    height: 1.35,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );
  static const authHeadline = TextStyle(
    color: AppColors.authNavy,
    fontSize: 24,
    height: 1.22,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.25,
  );
  static const fieldLabel = TextStyle(
    color: AppColors.authNavy,
    fontSize: 14,
    height: 1.3,
    fontWeight: FontWeight.w700,
  );
  static const fieldText = TextStyle(
    color: AppColors.inputText,
    fontSize: 16,
    height: 1.35,
  );
  static const fieldHint = TextStyle(
    color: AppColors.inputHint,
    fontSize: 16,
    height: 1.35,
  );
  static const button = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    height: 1.25,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.1,
  );
  static const dashboardSection = TextStyle(
    color: AppColors.authNavy,
    fontSize: 20,
    height: 1.28,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.3,
  );
  static const dashboardCardTitle = TextStyle(
    color: AppColors.black,
    fontSize: 16,
    height: 1.32,
    fontWeight: FontWeight.w700,
  );
  static const dashboardCaption = TextStyle(
    color: AppColors.inputIcon,
    fontSize: 12,
    height: 1.35,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );
}
