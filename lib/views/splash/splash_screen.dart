import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

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
    )..forward().whenComplete(_openOnboarding);
  }

  void _openOnboarding() {
    if (!mounted) return;

    // Navigates directly to the Onboarding screen
    context.go('/onboarding');
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
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
              filterQuality: FilterQuality.high,
            ),

            // Gently lifts the dark background so the blue brand mark remains
            // visible while the resort image keeps its original detail.
            const ColoredBox(color: AppColors.backgroundLift),

            const _SplashShade(),

            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return _SplashContent(
                    height: constraints.maxHeight,
                    progress: _progressController,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SplashShade extends StatelessWidget {
  const _SplashShade();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.transparent,
            AppColors.transparent,
            AppColors.navy,
          ],
          stops: [0.0, 0.58, 1.0],
        ),
      ),
    );
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent({required this.height, required this.progress});

  final double height;
  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Stack(
        children: [
          Positioned(
            top: height * 0.20,
            left: 0,
            right: 0,
            child: const _SplashLogo(),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: height * 0.095,
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
}

class _SplashLogo extends StatelessWidget {
  const _SplashLogo();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppConstants.blueBrandLogoPath,
          width: 320,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
          isAntiAlias: true,
        ),
        const SizedBox(height: 4),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'EXPERTISE  •  EXPERIENCE  •  EXCELLENCE',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.gold,
                fontSize: 8,
                height: 1.2,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SplashMessage extends StatelessWidget {
  const _SplashMessage();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          AppStrings.dreamHoliday,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 25,
            height: 1.15,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          AppStrings.ourExpertise,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: GoogleFonts.dancingScript(
            color: AppColors.sky,
            fontSize: 43,
            height: 1.05,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),

        const SizedBox(height: 12),

        const _GoldDivider(),

        const SizedBox(height: 14),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(
            AppStrings.splashDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 14,
              height: 1.55,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class _GoldDivider extends StatelessWidget {
  const _GoldDivider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          const Expanded(
            child: Divider(color: AppColors.gold, thickness: 1.2, height: 1),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Image.asset(
              AppConstants.goldPalmPath,
              width: 25,
              height: 25,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.park_outlined,
                  color: AppColors.gold,
                  size: 22,
                );
              },
            ),
          ),

          const Expanded(
            child: Divider(color: AppColors.gold, thickness: 1.2, height: 1),
          ),
        ],
      ),
    );
  }
}

class _SplashProgress extends StatelessWidget {
  const _SplashProgress({required this.progress});

  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          child: LinearProgressIndicator(
            value: progress.value,
            minHeight: 5,
            backgroundColor: AppColors.navyLight,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.sky),
          ),
        );
      },
    );
  }
}
