import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class DashboardInnerHeader extends StatelessWidget {
  const DashboardInnerHeader({
    required this.title,
    required this.subtitle,
    this.showBackButton = false,
    this.height = 260,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool showBackButton;
  final double height;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return SizedBox(
      height: height + topInset,
      child: Stack(
        fit: StackFit.expand,
        children: [
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
                          : () {},
                      icon: Icon(
                        showBackButton
                            ? Icons.chevron_left_rounded
                            : Icons.menu_rounded,
                        color: AppColors.white,
                        size: 31,
                      ),
                    ),
                    const Spacer(),
                    const Image(
                      image: AssetImage(AppAssets.brandLogo),
                      width: 165,
                      height: 72,
                      fit: BoxFit.contain,
                    ),
                    const Spacer(),
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
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                    fontSize: 15,
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
