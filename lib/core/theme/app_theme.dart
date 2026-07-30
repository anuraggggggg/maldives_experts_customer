import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData get light => _theme(Brightness.light);
  static ThemeData get dark => _theme(Brightness.dark);

  static ThemeData _theme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.navy,
      brightness: brightness,
      primary: isDark ? AppColors.gold : AppColors.navy,
      secondary: AppColors.lagoon,
      error: AppColors.error,
      surface: isDark ? AppColors.surfaceDark : AppColors.white,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark ? AppColors.navy : AppColors.sand,
      textTheme: const TextTheme(
        displaySmall: AppTextStyles.display,
        headlineSmall: AppTextStyles.headline,
        titleLarge: AppTextStyles.title,
        bodyLarge: AppTextStyles.body,
        labelLarge: AppTextStyles.label,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
