import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'widgets/booking_benefits.dart';
import 'widgets/dashboard_inner_header.dart';
import 'widgets/dashboard_swipe_navigator.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.light,
    child: Scaffold(
      backgroundColor: AppColors.white,
      body: DashboardSwipeNavigator(
        currentPage: DashboardPage.offers,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const DashboardInnerHeader(
                title: 'Latest Offers',
                subtitle: 'Exclusive deals for your dream Maldives getaway',
                showBackButton: true,
                height: 240,
              ),
              Transform.translate(
                offset: const Offset(0, -12),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.mdPlus,
                  ),
                  padding: const EdgeInsets.all(AppSpacing.smPlus),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.authNavy.withValues(alpha: 0.12),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const BookingBenefits(compact: true),
                ),
              ),
              const _OfferContent(),
              const SizedBox(height: AppSpacing.mdPlus),
              const _SubscribeBanner(),
              const SizedBox(height: AppSpacing.bottomNavClearance),
            ],
          ),
        ),
      ),
    ),
  );
}

class _OfferContent extends StatelessWidget {
  const _OfferContent();

  static const filters = <_OfferFilter>[
    _OfferFilter('All Offers', Icons.sell_outlined),
    _OfferFilter('Flash Deals', Icons.bolt_rounded),
    _OfferFilter('Resort Offers', Icons.apartment_rounded),
    _OfferFilter('Early Bird', Icons.calendar_today_outlined),
    _OfferFilter('Last Minute', Icons.schedule_rounded),
  ];

  static const offers = <_OfferData>[
    _OfferData(
      kicker: '⚡ FLASH DEAL ⚡',
      title: 'Up to 30% OFF',
      subtitle: 'on All-Inclusive Resorts',
      detail: 'Book by 31 May 2025   |   2+ Nights Stay',
      button: 'View Deals',
      badge: '30%\nOFF',
      image: AppAssets.dashboardHero,
      badgeColor: AppColors.googleRed,
    ),
    _OfferData(
      kicker: 'EARLY BIRD OFFER',
      title: 'Save 20% Early',
      subtitle: 'Plan Ahead & Save More',
      detail: 'Book 60 Days in Advance   |   2+ Nights Stay',
      button: 'View Resorts',
      badge: '20%\nOFF',
      image: AppAssets.destinationMale,
      badgeColor: AppColors.successDark,
    ),
    _OfferData(
      kicker: 'LAST MINUTE DEAL',
      title: 'Last Minute Escape',
      subtitle: 'Great Deals, Last Minute!',
      detail: 'Travel Within 7 Days   |   2+ Nights Stay',
      button: 'View Deals',
      badge: '15%\nOFF',
      image: AppAssets.destinationBaa,
      badgeColor: AppColors.orange,
    ),
    _OfferData(
      kicker: '💕 HONEYMOON SPECIAL 💕',
      title: 'Romance in Paradise',
      subtitle: 'Extra Benefits for Honeymooners',
      detail: 'Complimentary Dinner   |   Honeymoon Amenities',
      button: 'View Packages',
      badge: 'Special\nBenefits',
      image: AppAssets.destinationRaa,
      badgeColor: AppColors.shortcutPink,
    ),
  ];

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.regular),
    padding: const EdgeInsets.all(AppSpacing.smPlus),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.07),
          blurRadius: 18,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.xs),
            itemBuilder: (_, index) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                gradient: index == 0 ? AppColors.authGradient : null,
                color: index == 0 ? null : AppColors.white,
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
              child: Row(
                children: [
                  Icon(
                    filters[index].icon,
                    color: index == 0 ? AppColors.white : AppColors.navInactive,
                    size: 19,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    filters[index].label,
                    style: TextStyle(
                      color: index == 0
                          ? AppColors.white
                          : AppColors.navInactive,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.smPlus),
        ...offers.map(
          (offer) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.smPlus),
            child: _OfferCard(data: offer),
          ),
        ),
        const Text(
          'More Exclusive Benefits',
          style: TextStyle(
            color: AppColors.authNavy,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.smPlus),
        const _ExtraBenefits(),
      ],
    ),
  );
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({required this.data});

  final _OfferData data;

  @override
  Widget build(BuildContext context) => Container(
    height: 235 * MediaQuery.textScalerOf(context).scale(1),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(AppSpacing.sm),
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(data.image, fit: BoxFit.cover),
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
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.compact),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.kicker,
                style: const TextStyle(
                  color: AppColors.yellow,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                data.title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 21,
                  height: 1,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                data.subtitle,
                style: const TextStyle(color: AppColors.white, fontSize: 12),
              ),
              const SizedBox(height: 7),
              Text(
                data.detail,
                style: const TextStyle(color: AppColors.white, fontSize: 12),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data.button,
                      style: const TextStyle(
                        color: AppColors.authNavy,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 18),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.dashboardBlue,
                      size: 17,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 14,
          top: 15,
          child: Container(
            width: 62,
            height: 62,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: data.badgeColor,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 2),
            ),
            child: Text(
              data.badge,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 14,
                height: 1,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _ExtraBenefits extends StatelessWidget {
  const _ExtraBenefits();

  static const items = [
    (
      'Free Upgrade',
      'Room upgrade on\nselected resorts',
      Icons.card_giftcard_rounded,
      AppColors.featureGreen,
      AppColors.successDark,
    ),
    (
      'Free Transfer',
      'Complimentary\nseaplane transfer*',
      Icons.flight_takeoff_rounded,
      AppColors.featureBlue,
      AppColors.dashboardBlue,
    ),
    (
      'All-Inclusive',
      'Meals, drinks &\nactivities included',
      Icons.restaurant_rounded,
      AppColors.featurePurple,
      AppColors.shortcutPurple,
    ),
    (
      'Extra Discounts',
      'Additional savings on\nselected dates',
      Icons.sell_outlined,
      AppColors.featureOrange,
      AppColors.orange,
    ),
  ];

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 200 * MediaQuery.textScalerOf(context).scale(1),
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
      itemBuilder: (_, index) => Container(
        width: 180,
        padding: const EdgeInsets.all(AppSpacing.smPlus),
        decoration: BoxDecoration(
          color: items[index].$4,
          borderRadius: BorderRadius.circular(AppSpacing.sm),
        ),
        child: Row(
          children: [
            Icon(items[index].$3, color: items[index].$5, size: 28),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    items[index].$1,
                    style: const TextStyle(
                      color: AppColors.authNavy,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    items[index].$2,
                    style: const TextStyle(
                      color: AppColors.inputIcon,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _SubscribeBanner extends StatelessWidget {
  const _SubscribeBanner();

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.regular),
    padding: const EdgeInsets.all(AppSpacing.compact),
    decoration: BoxDecoration(
      color: AppColors.paleBlueSurface,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      border: Border.all(color: AppColors.blueBorder),
    ),
    child: LayoutBuilder(
      builder: (context, constraints) => constraints.maxWidth < 430
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    _SubscribeIcon(),
                    SizedBox(width: AppSpacing.compact),
                    Expanded(child: _SubscribeCopy()),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text('Subscribe Now →'),
                  ),
                ),
              ],
            )
          : Row(
              children: [
                const _SubscribeIcon(),
                const SizedBox(width: AppSpacing.compact),
                const Expanded(child: _SubscribeCopy()),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Subscribe Now →'),
                ),
              ],
            ),
    ),
  );
}

class _SubscribeIcon extends StatelessWidget {
  const _SubscribeIcon();

  @override
  Widget build(BuildContext context) => Container(
    width: 44,
    height: 44,
    decoration: const BoxDecoration(
      color: AppColors.dashboardBlue,
      shape: BoxShape.circle,
    ),
    child: const Icon(Icons.mail_outline, color: AppColors.white),
  );
}

class _SubscribeCopy extends StatelessWidget {
  const _SubscribeCopy();

  @override
  Widget build(BuildContext context) => const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Don't Miss Any Offers!",
        style: TextStyle(
          color: AppColors.authNavy,
          fontWeight: FontWeight.w800,
        ),
      ),
      Text(
        'Subscribe to get exclusive offers and updates',
        style: TextStyle(color: AppColors.inputIcon, fontSize: 12),
      ),
    ],
  );
}

class _OfferFilter {
  const _OfferFilter(this.label, this.icon);
  final String label;
  final IconData icon;
}

class _OfferData {
  const _OfferData({
    required this.kicker,
    required this.title,
    required this.subtitle,
    required this.detail,
    required this.button,
    required this.badge,
    required this.image,
    required this.badgeColor,
  });

  final String kicker;
  final String title;
  final String subtitle;
  final String detail;
  final String button;
  final String badge;
  final String image;
  final Color badgeColor;
}
