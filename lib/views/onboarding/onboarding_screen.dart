import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/routes/route_names.dart';
import '../../core/theme/app_colors.dart';

class OnboardingAdScreen extends StatelessWidget {
  const OnboardingAdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenWidth = mq.size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              AppConstants.authHeaderBackgroundPath,
              fit: BoxFit.cover,
            ),
          ),

          // Main Screen Layout
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // Top Bar (Skip Button)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Skip directly to Language Screen
                                context.goNamed(RouteNames.languageSelection);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text(
                                'Skip',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          // Brand Logo Header
                          const SizedBox(height: 10),
                          SizedBox(
                            width: screenWidth * 0.70,
                            child: Image.asset(
                              AppConstants.brandLogoPath,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Column(
                                    children: [
                                      Text(
                                        'Maldives',
                                        style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.authNavy,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                      Text(
                                        'EXPERTS',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.orange,
                                          letterSpacing: 4.0,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'EXPERTISE • EXPERIENCE • EXCELLENCE',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.authNavy,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                            ),
                          ),

                          const Spacer(),

                          // Heading Typography Section
                          const Text(
                            'Your Dream Holiday',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: AppColors.authNavy,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Our Expertise',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              color: AppColors.brightBlue,
                              fontFamily:
                                  'Cursive', // Falls back to default serif/italic if custom font isn't loaded
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Divider Icon
                          const Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: AppColors.yellow,
                                  thickness: 1,
                                  indent: 60,
                                  endIndent: 10,
                                ),
                              ),
                              Icon(
                                Icons.star_rounded,
                                size: 16,
                                color: AppColors.yellow,
                              ),
                              Expanded(
                                child: Divider(
                                  color: AppColors.yellow,
                                  thickness: 1,
                                  indent: 10,
                                  endIndent: 60,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Subtitle Paragraph
                          const Text(
                            'Discover the breathtaking beauty of Maldives with curated packages, luxury resorts, exciting activities and unforgettable experiences.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.slateDark,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'We make every journey exceptional.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.authNavy,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // 3 Feature Highlights Row
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: _FeatureItem(
                                  icon: Icons.beach_access,
                                  title: 'Curated Packages',
                                  subtitle: 'Handpicked holidays\njust for you',
                                ),
                              ),
                              Expanded(
                                child: _FeatureItem(
                                  icon: Icons.apartment,
                                  title: 'Luxury Stays',
                                  subtitle: 'Top-rated resorts\nat best prices',
                                ),
                              ),
                              Expanded(
                                child: _FeatureItem(
                                  icon: Icons.scuba_diving,
                                  title: 'Exciting Activities',
                                  subtitle:
                                      'Explore adventures\nabove & below water',
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Next Action Button
                          Container(
                            height: 52,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.deepBlue,
                                  AppColors.vividBlue,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.authBlue.withValues(
                                    alpha: 0.35,
                                  ),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(26),
                                onTap: () {
                                  // Navigate to Language Selection Screen
                                  context.goNamed(RouteNames.languageSelection);
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Next',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Page Indicator Dots
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.brightBlue,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Rounded Badge Background
        Container(
          width: 54,
          height: 54,
          decoration: const BoxDecoration(
            color: AppColors.softBlue,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.authBlue, size: 26),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: AppColors.authNavy,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.slate,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
