import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return SizedBox(
      height: 235 + topInset,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage(AppAssets.dashboardHero),
            fit: BoxFit.cover,
            alignment: Alignment.centerRight,
            filterQuality: FilterQuality.high,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.heroOverlayTop,
                  AppColors.heroOverlayMiddle,
                  AppColors.heroOverlayBottom,
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.regular,
              topInset + AppSpacing.sm,
              AppSpacing.regular,
              AppSpacing.content,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _HeaderIcon(
                      icon: Icons.menu_rounded,
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                    const Spacer(),
                    const Hero(
                      tag: 'dashboard-brand-logo',
                      child: Image(
                        image: AssetImage(AppAssets.brandLogo),
                        width: 190,
                        height: 82,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Spacer(),
                    const _NotificationButton(),
                    const SizedBox(width: AppSpacing.sm),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.paleBlue,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: AppColors.authNavy,
                        size: 27,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Text(
                  AppStrings.greeting,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    shadows: [Shadow(color: AppColors.authNavy, blurRadius: 5)],
                  ),
                ),

                const Text(
                  AppStrings.greetingSubtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    height: 1.2,
                    fontWeight: FontWeight.w500,
                    shadows: [Shadow(color: AppColors.authNavy, blurRadius: 5)],
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

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({required this.icon, this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed ?? () {},
    icon: Icon(icon, color: AppColors.white, size: 32),
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints.tightFor(width: 42, height: 42),
  );
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton();

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 38,
    height: 42,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        const Positioned.fill(
          child: _HeaderIcon(icon: Icons.notifications_none),
        ),
        Positioned(
          right: -1,
          top: -2,
          child: Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.orange,
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
  );
}
