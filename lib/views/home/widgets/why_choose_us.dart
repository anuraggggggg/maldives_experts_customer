import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import 'section_header.dart';

class WhyChooseUs extends StatelessWidget {
  const WhyChooseUs({super.key});

  static const _items = <_TrustItem>[
    _TrustItem(
      'Best Price\nGuarantee',
      Icons.verified_user_outlined,
      AppColors.featureBlue,
      AppColors.brightBlue,
    ),
    _TrustItem(
      'Secure\nBooking',
      Icons.gpp_good_outlined,
      AppColors.featureGreen,
      AppColors.successDark,
    ),
    _TrustItem(
      '24/7\nSupport',
      Icons.support_agent_rounded,
      AppColors.featureOrange,
      AppColors.orange,
    ),
    _TrustItem(
      'Local Maldives\nExperts',
      Icons.person_pin_circle_outlined,
      AppColors.softBlue,
      AppColors.dashboardBlue,
    ),
  ];

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SectionHeader(title: AppStrings.whyBookWithUs),
      const SizedBox(height: AppSpacing.sm),
      SizedBox(
        height: 86,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.regular),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: _items.length,
          separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.lg),
          itemBuilder: (_, index) => SizedBox(
            width: 72,
            child: Column(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: _items[index].background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _items[index].icon,
                    size: 23,
                    color: _items[index].foreground,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _items[index].title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.authNavy,
                    fontSize: 10.5,
                    height: 1.12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

class _TrustItem {
  const _TrustItem(this.title, this.icon, this.background, this.foreground);

  final String title;
  final IconData icon;
  final Color background;
  final Color foreground;
}
