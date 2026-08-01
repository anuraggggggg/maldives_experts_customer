import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class OfferBanner extends StatelessWidget {
  const OfferBanner({super.key});

  @override
  Widget build(BuildContext context) => Container(
    height: 158,
    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.regular),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      boxShadow: [
        BoxShadow(
          color: AppColors.authNavy.withValues(alpha: 0.14),
          blurRadius: 14,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      fit: StackFit.expand,
      children: [
        const Image(
          image: AssetImage(AppAssets.offerBanner),
          fit: BoxFit.cover,
          alignment: Alignment.bottomRight,
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.navyDark,
                AppColors.offerOverlayMiddle,
                AppColors.offerOverlayEnd,
              ],
              stops: [0, 0.48, 1],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.smPlus),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppStrings.summerSale,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              const Text(
                AppStrings.summerDiscount,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                ),
              ),
              const Text(
                AppStrings.selectedResorts,
                style: TextStyle(color: AppColors.white, fontSize: 12),
              ),
              const Spacer(),
              SizedBox(
                height: 35,
                child: FilledButton.icon(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.authNavy,
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.xs),
                    ),
                  ),
                  label: const Text(
                    AppStrings.exploreDeals,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                  ),
                  icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                  iconAlignment: IconAlignment.end,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 20,
          top: 28,
          child: Transform.rotate(
            angle: 0.12,
            child: Container(
              width: 69,
              height: 69,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.orange,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 1.5),
              ),
              child: const Text(
                AppStrings.limitedOffer,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 11,
                  height: 1.05,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        const Positioned(
          left: 0,
          right: 0,
          bottom: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_Dot(active: true), _Dot(), _Dot()],
          ),
        ),
      ],
    ),
  );
}

class _Dot extends StatelessWidget {
  const _Dot({this.active = false});

  final bool active;

  @override
  Widget build(BuildContext context) => Container(
    width: 7,
    height: 7,
    margin: const EdgeInsets.symmetric(horizontal: 3),
    decoration: BoxDecoration(
      color: AppColors.white.withValues(alpha: active ? 1 : 0.65),
      shape: BoxShape.circle,
    ),
  );
}
