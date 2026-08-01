import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'widgets/booking_benefits.dart';
import 'widgets/dashboard_category_tabs.dart';
import 'widgets/dashboard_inner_header.dart';
import 'widgets/dashboard_swipe_navigator.dart';
import 'widgets/section_header.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.light,
    child: Scaffold(
      backgroundColor: AppColors.white,
      body: DashboardSwipeNavigator(
        currentPage: DashboardPage.activities,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const DashboardInnerHeader(
                title: 'Activities',
                subtitle: 'Discover unforgettable experiences\nin the Maldives',
              ),
              Transform.translate(
                offset: const Offset(0, -16),
                child: const _ActivitySearchPanel(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.content),
                child: BookingBenefits(),
              ),
              const SizedBox(height: AppSpacing.md),
              const _ActivityCategories(),
              const SizedBox(height: AppSpacing.md),
              const _PopularActivities(),
              const SizedBox(height: AppSpacing.mdPlus),
              const _ActivityOfferBanner(),
              const SizedBox(height: AppSpacing.mdPlus),
              const _ActivityReasons(),
              const SizedBox(height: AppSpacing.bottomNavClearance),
            ],
          ),
        ),
      ),
    ),
  );
}

class _ActivitySearchPanel extends StatelessWidget {
  const _ActivitySearchPanel();

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.smPlus),
    padding: const EdgeInsets.all(AppSpacing.smPlus),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      boxShadow: [
        BoxShadow(
          color: AppColors.authNavy.withValues(alpha: 0.13),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: const Column(
      children: [
        DashboardCategoryTabs(selected: DashboardCategory.activities),
        SizedBox(height: AppSpacing.smPlus),
        Row(
          children: [
            Expanded(
              child: _ActivityField(
                icon: Icons.location_on_outlined,
                label: 'Where do you want to go?',
                value: 'All Destinations',
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _ActivityField(
                icon: Icons.calendar_month_outlined,
                label: 'Check-in – Check-out',
                value: '20 May 2025 – 24 May 2025',
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _ActivityField(
                icon: Icons.person_outline_rounded,
                label: 'Guests',
                value: '2 Adults • 0 Children',
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _ActivityField(
                icon: Icons.kayaking_outlined,
                label: 'Activity Type',
                value: 'All Activities',
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _ActivityField(
                icon: Icons.payments_outlined,
                label: 'Budget (per person)',
                value: 'Any Budget',
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(child: _SearchActivitiesButton()),
          ],
        ),
      ],
    ),
  );
}

class _ActivityField extends StatelessWidget {
  const _ActivityField({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
    height: 53,
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.authBorder),
      borderRadius: BorderRadius.circular(AppSpacing.sm),
    ),
    child: Row(
      children: [
        Icon(icon, color: AppColors.inputIcon, size: 19),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.inputIcon,
                  fontSize: 8.5,
                ),
              ),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.authNavy,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.inputIcon,
          size: 17,
        ),
      ],
    ),
  );
}

class _SearchActivitiesButton extends StatelessWidget {
  const _SearchActivitiesButton();

  @override
  Widget build(BuildContext context) => Container(
    height: 53,
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
    decoration: BoxDecoration(
      gradient: AppColors.dashboardActionGradient,
      borderRadius: BorderRadius.circular(AppSpacing.sm),
    ),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Search Activities',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(width: AppSpacing.xs),
        Icon(Icons.arrow_forward_rounded, color: AppColors.white, size: 18),
      ],
    ),
  );
}

class _ActivityCategories extends StatelessWidget {
  const _ActivityCategories();

  static const categories = [
    ('Water Sports', Icons.surfing_rounded, AppAssets.destinationRaa),
    ('Snorkeling', Icons.scuba_diving_rounded, AppAssets.destinationBaa),
    ('Scuba Diving', Icons.water_rounded, AppAssets.dashboardHero),
    ('Island Hopping', Icons.travel_explore_rounded, AppAssets.destinationMale),
    ('Fishing', Icons.phishing_rounded, AppAssets.offerBanner),
    ('Sunset Cruises', Icons.sailing_rounded, AppAssets.destinationRaa),
    ('Spas', Icons.spa_outlined, AppAssets.destinationBaa),
    (
      'Spa & Wellness',
      Icons.self_improvement_rounded,
      AppAssets.destinationBaa,
    ),
    (
      'Cultural Experiences',
      Icons.celebration_rounded,
      AppAssets.destinationMale,
    ),
  ];

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const SectionHeader(
        title: 'Browse Activities by Category',
        actionLabel: 'View All Categories',
      ),
      const SizedBox(height: AppSpacing.sm),
      SizedBox(
        height: 100,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.regular),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
          itemBuilder: (_, index) => SizedBox(
            width: 70,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.sm),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        categories[index].$3,
                        width: 68,
                        height: 65,
                        fit: BoxFit.cover,
                      ),
                      Icon(
                        categories[index].$2,
                        color: AppColors.white,
                        size: 25,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  categories[index].$1,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.authNavy,
                    fontSize: 8.5,
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

class _PopularActivities extends StatelessWidget {
  const _PopularActivities();

  static const activities = <_ActivityData>[
    _ActivityData(
      'Jet Ski Adventure',
      'Malé Atoll',
      '30 Minutes',
      89,
      '4.8',
      'Best Seller',
      AppAssets.destinationRaa,
    ),
    _ActivityData(
      'Snorkeling Trip',
      'Banana Reef, North Malé Atoll',
      '2 Hours',
      49,
      '4.7',
      'Most Popular',
      AppAssets.destinationBaa,
    ),
    _ActivityData(
      'Scuba Diving Experience',
      'Ari Atoll',
      '3 Hours',
      129,
      '4.9',
      'Top Rated',
      AppAssets.dashboardHero,
    ),
    _ActivityData(
      'Island Hopping Tour',
      'South Ari Atoll',
      '6 Hours',
      79,
      '4.6',
      'Great Value',
      AppAssets.destinationMale,
    ),
    _ActivityData(
      'Sunset Cruise',
      'Malé Atoll',
      '2 Hours',
      59,
      '4.7',
      'Sunset Special',
      AppAssets.destinationRaa,
    ),
    _ActivityData(
      'Parasailing Adventure',
      'Hulhumalé',
      '15 Minutes',
      75,
      '4.5',
      'Thrilling',
      AppAssets.destinationBaa,
    ),
    _ActivityData(
      'Big Game Fishing',
      'Vaavu Atoll',
      '4 Hours',
      109,
      '4.8',
      'Deep Sea',
      AppAssets.offerBanner,
    ),
    _ActivityData(
      'Spa & Wellness',
      'Various Resorts',
      '1.5 Hours',
      65,
      '4.6',
      'Relax & Unwind',
      AppAssets.destinationBaa,
    ),
  ];

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const SectionHeader(
        title: 'Popular Activities',
        actionLabel: 'View All Activities',
      ),
      const SizedBox(height: AppSpacing.sm),
      LayoutBuilder(
        builder: (context, constraints) {
          final count = constraints.maxWidth >= 700
              ? 4
              : constraints.maxWidth >= 450
              ? 3
              : 2;
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.regular),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: count,
              crossAxisSpacing: AppSpacing.sm,
              mainAxisSpacing: AppSpacing.smPlus,
              childAspectRatio: count >= 3 ? 0.68 : 0.70,
            ),
            itemBuilder: (_, index) => _ActivityCard(data: activities[index]),
          );
        },
      ),
    ],
  );
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({required this.data});

  final _ActivityData data;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.08),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(data.image, fit: BoxFit.cover),
              Positioned(
                left: 7,
                top: 7,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.dashboardBlue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    data.badge,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const Positioned(
                top: 7,
                right: 7,
                child: Icon(
                  Icons.favorite_border,
                  color: AppColors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.authNavy,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '⌖ ${data.location}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.dashboardBlue,
                    fontSize: 8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '◷ ${data.duration}',
                  style: const TextStyle(
                    color: AppColors.inputIcon,
                    fontSize: 8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '⭐ ${data.rating}  (${data.price * 11} Reviews)',
                  style: const TextStyle(
                    color: AppColors.inputIcon,
                    fontSize: 8,
                  ),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        'From\n\$${data.price}',
                        style: const TextStyle(
                          color: AppColors.dashboardBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const Text(
                      'Per Person',
                      style: TextStyle(
                        color: AppColors.inputIcon,
                        fontSize: 7.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _ActivityOfferBanner extends StatelessWidget {
  const _ActivityOfferBanner();

  @override
  Widget build(BuildContext context) => Container(
    height: 150,
    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.regular),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      gradient: const LinearGradient(
        colors: [AppColors.navyDark, AppColors.dashboardCyan],
      ),
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          width: 180,
          child: Image.asset(AppAssets.destinationMale, fit: BoxFit.cover),
        ),
        const Padding(
          padding: EdgeInsets.all(AppSpacing.compact),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Make Your Maldives Experience Extra Special',
                style: TextStyle(color: AppColors.white, fontSize: 12),
              ),
              Text(
                'Up to 25% OFF',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'on selected activities when booked with a package',
                style: TextStyle(color: AppColors.white, fontSize: 10),
              ),
              Spacer(),
              _ExploreButton(),
            ],
          ),
        ),
        Positioned(
          right: 18,
          top: 22,
          child: Container(
            width: 67,
            height: 67,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.orange,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 2),
            ),
            child: const Text(
              'Limited\nTime\nOffer!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _ExploreButton extends StatelessWidget {
  const _ExploreButton();

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(4),
    ),
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      child: Text(
        'Explore Deals  →',
        style: TextStyle(
          color: AppColors.dashboardBlue,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

class _ActivityReasons extends StatelessWidget {
  const _ActivityReasons();

  static const reasons = [
    (
      'Handpicked\nExperiences',
      'Curated by local\nMaldives experts',
      Icons.workspace_premium_outlined,
    ),
    (
      'Safe & Secure',
      'Licensed operators\n& safety assured',
      Icons.health_and_safety_outlined,
    ),
    (
      'Flexible\nCancellation',
      'Free cancellation on\nmost activities',
      Icons.event_available_outlined,
    ),
    (
      'Instant\nVouchers',
      'E-vouchers accepted\nat all locations',
      Icons.confirmation_number_outlined,
    ),
    (
      'Best Price\nGuaranteed',
      'Unbeatable prices\nwith no hidden fees',
      Icons.people_outline_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.regular),
        child: Text(
          'Why Book Activities with Maldives Experts?',
          style: TextStyle(
            color: AppColors.authNavy,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      const SizedBox(height: AppSpacing.smPlus),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.regular),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: reasons
              .map(
                (reason) => Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: const BoxDecoration(
                          color: AppColors.featureGreen,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          reason.$3,
                          color: AppColors.successDark,
                          size: 21,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        reason.$1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.authNavy,
                          fontSize: 8.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        reason.$2,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.inputIcon,
                          fontSize: 7,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(growable: false),
        ),
      ),
    ],
  );
}

class _ActivityData {
  const _ActivityData(
    this.name,
    this.location,
    this.duration,
    this.price,
    this.rating,
    this.badge,
    this.image,
  );

  final String name;
  final String location;
  final String duration;
  final int price;
  final String rating;
  final String badge;
  final String image;
}
