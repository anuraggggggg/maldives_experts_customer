import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/network_image_widget.dart';

class DashboardInnerHeader extends StatelessWidget {
  const DashboardInnerHeader({
    required this.title,
    required this.subtitle,
    this.showBackButton = false,
    this.height = 260,
    this.backgroundImageUrl,
    this.onMenuPressed,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool showBackButton;
  final double height;
  final String? backgroundImageUrl;
  final VoidCallback? onMenuPressed;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    final wide = MediaQuery.sizeOf(context).width >= 700;

    return SizedBox(
      height: height + topInset + AppSpacing.md,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (backgroundImageUrl != null)
            NetworkImageWidget(url: backgroundImageUrl!)
          else
            const Image(
              image: AssetImage(AppAssets.dashboardHero),
              fit: BoxFit.cover,
              alignment: Alignment.centerRight,
            ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.heroOverlayBottom,
                  AppColors.transparent,
                  AppColors.heroOverlayTop,
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.content,
              topInset + AppSpacing.sm,
              AppSpacing.content,
              AppSpacing.content,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: showBackButton
                          ? () => context.go('/home')
                          : onMenuPressed ?? () {},
                      icon: Icon(
                        showBackButton
                            ? Icons.chevron_left_rounded
                            : Icons.menu_rounded,
                        color: AppColors.white,
                        size: 31,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Image(
                      image: const AssetImage(AppAssets.brandLogo),
                      width: wide ? 175 : 140,
                      height: 72,
                      fit: BoxFit.contain,
                    ),
                    const Spacer(),
                    if (wide) ...[
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.phone_outlined, size: 18),
                        label: const Text('Talk to Expert'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Color(0x99FFFFFF)),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                    ],
                    const Icon(
                      Icons.favorite_border_rounded,
                      color: AppColors.white,
                      size: 28,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(
                          Icons.notifications_none_rounded,
                          color: AppColors.white,
                          size: 29,
                        ),
                        Positioned(
                          right: -5,
                          top: -6,
                          child: Container(
                            width: 18,
                            height: 18,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: AppColors.googleRed,
                              shape: BoxShape.circle,
                            ),
                            child: const Text(
                              '3',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (wide) ...[
                      const SizedBox(width: AppSpacing.lg),
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.paleBlue,
                        child: Icon(
                          Icons.person_rounded,
                          color: AppColors.authNavy,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const Text(
                        'Hi, John',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white,
                        size: 19,
                      ),
                    ],
                  ],
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 32,
                    height: 1,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.7,
                  ),
                ),
                const SizedBox(height: AppSpacing.smPlus),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
