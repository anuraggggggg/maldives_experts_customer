import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class BookingBenefits extends StatelessWidget {
  const BookingBenefits({this.compact = false, super.key});

  final bool compact;

  static const items = <BookingBenefit>[
    BookingBenefit(
      'Best Price Guarantee',
      Icons.gpp_good_outlined,
      AppColors.featureGreen,
      AppColors.successDark,
    ),
    BookingBenefit(
      'Instant Confirmation',
      Icons.bolt_rounded,
      AppColors.featureBlue,
      AppColors.dashboardBlue,
    ),
    BookingBenefit(
      'Secure Booking',
      Icons.lock_outline_rounded,
      AppColors.featurePurple,
      AppColors.shortcutPurple,
    ),
    BookingBenefit(
      '24/7 Support',
      Icons.support_agent_rounded,
      AppColors.featureOrange,
      AppColors.orange,
    ),
    BookingBenefit(
      'Free Transfers',
      Icons.flight_takeoff_rounded,
      AppColors.featureTeal,
      AppColors.shortcutTeal,
    ),
    BookingBenefit(
      'Exclusive Benefits',
      Icons.card_giftcard_rounded,
      AppColors.featurePink,
      AppColors.shortcutPink,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final visibleItems = compact ? items.take(4).toList() : items;
    return SizedBox(
      height: compact ? 68 : 74,
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
                    const SizedBox(height: 2),
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.authNavy,
                        fontSize: compact ? 9 : 9.5,
                        height: 1.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
  const BookingBenefit(this.title, this.icon, this.background, this.foreground);

  final String title;
  final IconData icon;
  final Color background;
  final Color foreground;
}
