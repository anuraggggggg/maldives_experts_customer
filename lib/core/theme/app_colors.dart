import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();

  // Brand colors
  static const Color navy = Color(0xFF012662);
  static const Color navyDark = Color(0xFF071F5E);
  static const Color navyLight = Color(0xFF024E9B);

  static const Color primary = Color(0xFF024E9B);
  static const Color actionBlue = Color(0xFF0266B4);
  static const Color authBlue = Color(0xFF0066CC);
  static const Color brightBlue = Color(0xFF0088FF);
  static const Color vividBlue = Color(0xFF0099FF);
  static const Color deepBlue = Color(0xFF0044B3);
  static const Color royalBlue = Color(0xFF0052CC);
  static const Color authNavy = Color(0xFF0F2540);
  static const Color sky = Color(0xFF02BBE4);
  static const Color lagoon = Color(0xFF75C7D1);
  static const Color gold = Color(0xFFE49E24);
  static const Color orange = Color(0xFFFF9900);
  static const Color yellow = Color(0xFFFFB800);

  // Neutral colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF252525);
  static const Color transparent = Colors.transparent;
  static const Color backgroundLift = Color(0x1FFFFFFF);

  // Background and surfaces
  static const Color background = Color(0xFFF7F7F8);
  static const Color sand = Color(0xFFF7F7F8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF071F5E);
  static const Color fieldFill = Color(0xFFFDFDFD);
  static const Color authBackground = Color(0xFFF8FAFC);
  static const Color authFieldFill = Color(0xFFF9FAFB);
  static const Color paleBlue = Color(0xFFE6F0FA);
  static const Color paleBlueSurface = Color(0xFFEEF6FF);
  static const Color blueSurface = Color(0xFFF0F7FF);
  static const Color blueTint = Color(0xFFE6F2FF);
  static const Color softBlue = Color(0xFFE2F1FF);
  static const Color blueBorder = Color(0xFFD0E4FF);
  static const Color blueIconSurface = Color(0xFFD9EBFF);
  static const Color successSurface = Color(0xFFDCFCE7);

  // Text colors
  static const Color textPrimary = Color(0xFF252525);
  static const Color mutedText = Color(0xFF8F8F94);
  static const Color placeholder = Color(0xFF8F8F94);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color slate = Color(0xFF64748B);
  static const Color slateDark = Color(0xFF334155);
  static const Color inputText = Color(0xFF1F2937);
  static const Color inputIcon = Color(0xFF6B7280);
  static const Color inputHint = Color(0xFF94A3B8);
  static const Color inactive = Color(0xFF9CA3AF);

  // Border and state colors
  static const Color border = Color(0xFFD9DEE5);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color disabled = Color(0xFFB8BBC1);
  static const Color error = Color(0xFFBA1A1A);
  static const Color success = Color(0xFF1A9B69);
  static const Color warning = Color(0xFFE49E24);
  static const Color authBorder = Color(0xFFE2E8F0);
  static const Color lightGrey = Color(0xFFF3F4F6);
  static const Color mediumGrey = Color(0xFFD1D5DB);
  static const Color successBright = Color(0xFF10B981);
  static const Color successDark = Color(0xFF16A34A);
  static const Color dashboardBlue = Color(0xFF0754E8);
  static const Color dashboardCyan = Color(0xFF04A9EC);
  static const Color navInactive = Color(0xFF66666F);
  static const Color featureBlue = Color(0xFFDDF3FF);
  static const Color featureGreen = Color(0xFFE2F7E8);
  static const Color featureOrange = Color(0xFFFFEBD8);
  static const Color featurePurple = Color(0xFFECE2FF);
  static const Color featurePink = Color(0xFFFFE2E8);
  static const Color featureTeal = Color(0xFFDDF8F4);
  static const Color shortcutPurple = Color(0xFF7C35D8);
  static const Color shortcutPink = Color(0xFFE83962);
  static const Color shortcutTeal = Color(0xFF00A8A8);
  static const Color heroOverlayTop = Color(0x39001355);
  static const Color heroOverlayMiddle = Color(0x08001355);
  static const Color heroOverlayBottom = Color(0x50001355);
  static const Color offerOverlayMiddle = Color(0xDD07377E);
  static const Color offerOverlayEnd = Color(0x2307377E);

  static const LinearGradient dashboardActionGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [dashboardBlue, dashboardCyan],
  );

  // Social colors
  static const Color facebook = Color(0xFF3578E5);
  static const Color facebookBlue = Color(0xFF1877F2);
  static const Color googleRed = Color(0xFFEA4335);
  static const Color apple = Color(0xFF000000);

  // Login button gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF063478), Color(0xFF066EB5)],
  );

  static const LinearGradient authGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [authNavy, authBlue],
  );

  // Splash/background gradient
  static const LinearGradient navyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF012662), Color(0xFF024E9B)],
  );
}
