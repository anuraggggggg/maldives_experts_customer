import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 900), () {
      if (mounted) context.go('/login');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
    backgroundColor: AppColors.navy,
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(AppSpacing.radius)),
            child: Image(
              image: AssetImage('assets/icons/app_icon.png'),
              width: 160,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            AppStrings.appName,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(AppStrings.appTagline, style: TextStyle(color: AppColors.white)),
        ],
      ),
    ),
  );
}
