import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_drawer.dart';
import '../../core/widgets/network_image_widget.dart';
import 'widgets/booking_benefits.dart';
import 'widgets/dashboard_category_tabs.dart';
import 'widgets/dashboard_inner_header.dart';
import 'widgets/dashboard_swipe_navigator.dart';
import 'widgets/section_header.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const AppDrawer(),
        backgroundColor: AppColors.white,
        body: DashboardSwipeNavigator(
          currentPage: DashboardPage.activities,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                DashboardInnerHeader(
                  title: 'Activities',
                  subtitle:
                      'Discover unforgettable experiences\nin the Maldives',
                  backgroundImageUrl:
                      'https://images.unsplash.com/photo-1540202404-a2f29016b523?auto=format&fit=crop&w=1800&q=90',
                  onMenuPressed: () => scaffoldKey.currentState?.openDrawer(),
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
    (
      'Water Sports',
      Icons.surfing_rounded,
      'https://images.unsplash.com/photo-1560275619-4662e36fa65c?auto=format&fit=crop&w=500&q=85',
    ),
    (
      'Snorkeling',
      Icons.scuba_diving_rounded,
      'https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=500&q=85',
    ),
    (
      'Scuba Diving',
      Icons.water_rounded,
      'https://images.unsplash.com/photo-1530053969600-caed2596d242?auto=format&fit=crop&w=500&q=85',
    ),
    (
      'Island Hopping',
      Icons.travel_explore_rounded,
      'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?auto=format&fit=crop&w=500&q=85',
    ),
    (
      'Fishing',
      Icons.phishing_rounded,
      'https://images.unsplash.com/photo-1544550285-f813152fb2fd?auto=format&fit=crop&w=500&q=85',
    ),
    (
      'Sunset Cruises',
      Icons.sailing_rounded,
      'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=500&q=85',
    ),
    (
      'Spas',
      Icons.spa_outlined,
      'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=500&q=85',
    ),
    (
      'Spa & Wellness',
      Icons.self_improvement_rounded,
      'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&w=500&q=85',
    ),
    (
      'Cultural Experiences',
      Icons.celebration_rounded,
      'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?auto=format&fit=crop&w=500&q=85',
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
        height: 132,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.regular),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
          itemBuilder: (_, index) => SizedBox(
            width: 98,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.sm),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 96,
                        height: 88,
                        child: NetworkImageWidget(url: categories[index].$3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  categories[index].$1,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.authNavy,
                    fontSize: 11.5,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
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
      'https://images.unsplash.com/photo-1560275619-4662e36fa65c?auto=format&fit=crop&w=900&q=85',
    ),
    _ActivityData(
      'Snorkeling Trip',
      'Banana Reef, North Malé Atoll',
      '2 Hours',
      49,
      '4.7',
      'Most Popular',
      'https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=900&q=85',
    ),
    _ActivityData(
      'Scuba Diving Experience',
      'Ari Atoll',
      '3 Hours',
      129,
      '4.9',
      'Top Rated',
      'https://images.unsplash.com/photo-1530053969600-caed2596d242?auto=format&fit=crop&w=900&q=85',
    ),
    _ActivityData(
      'Island Hopping Tour',
      'South Ari Atoll',
      '6 Hours',
      79,
      '4.6',
      'Great Value',
      'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?auto=format&fit=crop&w=900&q=85',
    ),
    _ActivityData(
      'Sunset Cruise',
      'Malé Atoll',
      '2 Hours',
      59,
      '4.7',
      'Sunset Special',
      'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=900&q=85',
    ),
    _ActivityData(
      'Parasailing Adventure',
      'Hulhumalé',
      '15 Minutes',
      75,
      '4.5',
      'Thrilling',
      'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=900&q=85',
    ),
    _ActivityData(
      'Big Game Fishing',
      'Vaavu Atoll',
      '4 Hours',
      109,
      '4.8',
      'Deep Sea',
      'https://images.unsplash.com/photo-1544550285-f813152fb2fd?auto=format&fit=crop&w=900&q=85',
    ),
    _ActivityData(
      'Spa & Wellness',
      'Various Resorts',
      '1.5 Hours',
      65,
      '4.6',
      'Relax & Unwind',
      'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&w=900&q=85',
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
              mainAxisExtent: count == 2
                  ? 360
                  : count == 3
                  ? 335
                  : 320,
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
              NetworkImageWidget(url: data.image),
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
                      fontSize: 10,
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
                  size: 24,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.authNavy,
                    fontSize: 14,
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
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '◷ ${data.duration}',
                  style: const TextStyle(
                    color: AppColors.slateDark,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '⭐ ${data.rating}  (${data.price * 11} Reviews)',
                  maxLines: 2,
                  style: const TextStyle(
                    color: AppColors.slateDark,
                    fontSize: 12,
                    height: 1.2,
                    fontWeight: FontWeight.w500,
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
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const Text(
                      'Per Person',
                      style: TextStyle(
                        color: AppColors.slateDark,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
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
        const Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          width: 180,
          child: NetworkImageWidget(
            url:
                'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=900&q=85',
          ),
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
