import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class BookingBenefits extends StatelessWidget {
  const BookingBenefits({this.compact = false, super.key});

  final bool compact;

  static const items = <BookingBenefit>[
    BookingBenefit(
      'Best Price\nGuarantee',
      'We match any price',
      Icons.gpp_good_outlined,
      AppColors.featureGreen,
      AppColors.successDark,
    ),
    BookingBenefit(
      'Instant\nConfirmation',
      'Quick & easy booking',
      Icons.bolt_rounded,
      AppColors.featureBlue,
      AppColors.dashboardBlue,
    ),
    BookingBenefit(
      'Secure\nBooking',
      '100% secure payments',
      Icons.lock_outline_rounded,
      AppColors.featurePurple,
      AppColors.shortcutPurple,
    ),
    BookingBenefit(
      '24/7\nSupport',
      "We're here anytime",
      Icons.support_agent_rounded,
      AppColors.featureOrange,
      AppColors.orange,
    ),
    BookingBenefit(
      'Free\nTransfers',
      'On selected resorts',
      Icons.flight_takeoff_rounded,
      AppColors.featureTeal,
      AppColors.shortcutTeal,
    ),
    BookingBenefit(
      'Exclusive\nBenefits',
      'Extra perks & offers',
      Icons.card_giftcard_rounded,
      AppColors.featurePink,
      AppColors.shortcutPink,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final visibleItems = compact ? items.take(4).toList() : items;
    return SizedBox(
      height: compact ? 76 : 112,
      child: Row(
        children: visibleItems
            .map(
              (item) => Expanded(
                child: Column(
                  children: [
                    Container(
                      width: compact ? 36 : 44,
                      height: compact ? 36 : 44,
                      decoration: BoxDecoration(
                        color: item.background,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item.icon,
                        color: item.foreground,
                        size: compact ? 21 : 25,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.authNavy,
                        fontSize: compact ? 9.5 : 10.5,
                        height: 1.1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (!compact) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        item.subtitle,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(
                          color: AppColors.inputIcon,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            )
            .toList(growable: false),
      ),
    );
  }
}

class BookingBenefit {
  const BookingBenefit(
    this.title,
    this.subtitle,
    this.icon,
    this.background,
    this.foreground,
  );

  final String title;
  final String subtitle;
  final IconData icon;
  final Color background;
  final Color foreground;
}
