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
    final textColor = scheme.onSurface;
    final textTheme = TextTheme(
      displayLarge: AppTextStyles.display.copyWith(fontSize: 40),
      displayMedium: AppTextStyles.display.copyWith(fontSize: 36),
      displaySmall: AppTextStyles.display,
      headlineLarge: AppTextStyles.headline.copyWith(fontSize: 28),
      headlineMedium: AppTextStyles.headline,
      headlineSmall: AppTextStyles.sectionTitle,
      titleLarge: AppTextStyles.title,
      titleMedium: AppTextStyles.title.copyWith(fontSize: 16),
      titleSmall: AppTextStyles.label,
      bodyLarge: AppTextStyles.body,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.caption,
      labelLarge: AppTextStyles.label,
      labelMedium: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
      labelSmall: AppTextStyles.caption,
    ).apply(bodyColor: textColor, displayColor: textColor);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark ? AppColors.navy : AppColors.sand,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        titleTextStyle: AppTextStyles.title.copyWith(color: textColor),
        toolbarTextStyle: AppTextStyles.bodyMedium.copyWith(color: textColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        labelStyle: AppTextStyles.fieldLabel,
        hintStyle: AppTextStyles.fieldHint,
        errorStyle: AppTextStyles.caption.copyWith(color: scheme.error),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.regular,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          borderSide: BorderSide.none,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(textStyle: AppTextStyles.label),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(textStyle: AppTextStyles.button),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(textStyle: AppTextStyles.label),
      ),
      dialogTheme: DialogThemeData(
        titleTextStyle: AppTextStyles.title.copyWith(color: textColor),
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: textColor),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        modalBackgroundColor: scheme.surface,
      ),
      listTileTheme: const ListTileThemeData(
        titleTextStyle: AppTextStyles.body,
        subtitleTextStyle: AppTextStyles.bodyMedium,
        contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
      ),
      snackBarTheme: const SnackBarThemeData(
        contentTextStyle: AppTextStyles.bodyMedium,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
