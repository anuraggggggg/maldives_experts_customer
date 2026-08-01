import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  static const display = TextStyle(fontSize: 32, fontWeight: FontWeight.w700);
  static const headline = TextStyle(fontSize: 24, fontWeight: FontWeight.w700);
  static const title = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  static const body = TextStyle(fontSize: 16);
  static const label = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
  static const authHeadline = TextStyle(
    color: AppColors.authNavy,
    fontSize: 24,
    fontWeight: FontWeight.w800,
  );
  static const fieldLabel = TextStyle(
    color: AppColors.authNavy,
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );
  static const fieldText = TextStyle(color: AppColors.inputText, fontSize: 14);
  static const fieldHint = TextStyle(color: AppColors.inputHint, fontSize: 14);
  static const button = TextStyle(
    color: AppColors.white,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );
  static const dashboardSection = TextStyle(
    color: AppColors.authNavy,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.4,
  );
  static const dashboardCardTitle = TextStyle(
    color: AppColors.black,
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );
  static const dashboardCaption = TextStyle(
    color: AppColors.inputIcon,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}
