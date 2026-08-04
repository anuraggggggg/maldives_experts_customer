import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class FeatureShortcuts extends StatelessWidget {
  const FeatureShortcuts({super.key});

  static const _features = <_FeatureData>[
    _FeatureData(
      'All Inclusive',
      Icons.beach_access_rounded,
      AppColors.featureBlue,
      AppColors.brightBlue,
    ),
    _FeatureData(
      'Honeymoon\nDeals',
      Icons.umbrella_rounded,
      AppColors.featureGreen,
      AppColors.successDark,
    ),
    _FeatureData(
      'Luxury\nResorts',
      Icons.stars_rounded,
      AppColors.featureOrange,
      AppColors.orange,
    ),
    _FeatureData(
      'Water\nActivities',
      Icons.scuba_diving_rounded,
      AppColors.featurePurple,
      AppColors.shortcutPurple,
    ),
    _FeatureData(
      'Special\nOffers',
      Icons.discount_rounded,
      AppColors.featurePink,
      AppColors.shortcutPink,
    ),
    _FeatureData(
      'Last Minute\nDeals',
      Icons.flight_rounded,
      AppColors.featureTeal,
      AppColors.shortcutTeal,
    ),
  ];

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 98,
    child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.regular),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: _features.length,
      separatorBuilder: (_, __) => const SizedBox.shrink(),
      itemBuilder: (_, index) => SizedBox(
        // Long labels such as "Honeymoon" need enough room to avoid an
        // unintended third line while keeping every shortcut aligned.
        width: 72,
        child: Column(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: _features[index].background,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _features[index].icon,
                color: _features[index].foreground,
                size: 28,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              _features[index].label,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.authNavy,
                fontSize: 12,
                height: 1.12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _FeatureData {
  const _FeatureData(this.label, this.icon, this.background, this.foreground);

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
}
