import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: AppConstants.splashDuration,
    )..forward().whenComplete(_openLogin);
  }

  void _openLogin() {
    if (mounted) context.go('/login');
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.navy,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
    child: Scaffold(
      backgroundColor: AppColors.navy,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage(AppConstants.splashBackgroundPath),
            fit: BoxFit.cover,
          ),
          const _SplashShade(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => _SplashContent(
                height: constraints.maxHeight,
                progress: _progressController,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _SplashShade extends StatelessWidget {
  const _SplashShade();

  @override
  Widget build(BuildContext context) => const DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.transparent, AppColors.transparent, AppColors.navy],
        stops: [0, 0.68, 1],
      ),
    ),
  );
}

class _SplashContent extends StatelessWidget {
  const _SplashContent({required this.height, required this.progress});

  final double height;
  final Animation<double> progress;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
    child: Stack(
      children: [
        Positioned(
          top: height * 0.22,
          left: 0,
          right: 0,
          child: const Image(
            image: AssetImage(AppConstants.splashLogoPath),
            height: 210,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: height * 0.09,
          child: const _SplashMessage(),
        ),
        Positioned(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          bottom: height * 0.035,
          child: _SplashProgress(progress: progress),
        ),
      ],
    ),
  );
}

class _SplashMessage extends StatelessWidget {
  const _SplashMessage();

  @override
  Widget build(BuildContext context) => const Column(
    children: [
      Text(
        AppStrings.dreamHoliday,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ),
      ),
      SizedBox(height: AppSpacing.xs),
      Text(
        AppStrings.ourExpertise,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.sky,
          fontSize: 31,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w400,
        ),
      ),
      SizedBox(height: AppSpacing.md),
      _GoldDivider(),
      SizedBox(height: AppSpacing.md),
      Text(
        AppStrings.splashDescription,
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.white, fontSize: 14, height: 1.5),
      ),
    ],
  );
}

class _GoldDivider extends StatelessWidget {
  const _GoldDivider();

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(width: 72, height: 1, color: AppColors.gold),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: Icon(Icons.wb_sunny_outlined, color: AppColors.gold, size: 17),
      ),
      Container(width: 72, height: 1, color: AppColors.gold),
    ],
  );
}

class _SplashProgress extends StatelessWidget {
  const _SplashProgress({required this.progress});

  final Animation<double> progress;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: progress,
    builder: (context, _) => ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.sm),
      child: LinearProgressIndicator(
        value: progress.value,
        minHeight: 5,
        backgroundColor: AppColors.navyLight,
        valueColor: const AlwaysStoppedAnimation(AppColors.sky),
      ),
    ),
  );
}
