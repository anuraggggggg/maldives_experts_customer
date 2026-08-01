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

class ResortsScreen extends StatelessWidget {
  const ResortsScreen({super.key});

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.light,
    child: Scaffold(
      backgroundColor: AppColors.white,
      body: DashboardSwipeNavigator(
        currentPage: DashboardPage.resorts,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const DashboardInnerHeader(
                title: 'Featured Resorts',
                subtitle:
                    'Handpicked luxury resorts for your perfect stay\nin the Maldives',
              ),
              Transform.translate(
                offset: const Offset(0, -18),
                child: const _ResortSearchPanel(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.content),
                child: BookingBenefits(),
              ),
              const SizedBox(height: AppSpacing.md),
              const SectionHeader(
                title: 'Top Rated Resorts',
                actionLabel: 'View All Resorts',
              ),
              const SizedBox(height: AppSpacing.sm),
              const _ResortGrid(),
              const SizedBox(height: AppSpacing.md),
              const _ExpertBanner(),
              const SizedBox(height: AppSpacing.bottomNavClearance),
            ],
          ),
        ),
      ),
    ),
  );
}

class _ResortSearchPanel extends StatelessWidget {
  const _ResortSearchPanel();

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
        DashboardCategoryTabs(selected: DashboardCategory.resorts),
        SizedBox(height: AppSpacing.smPlus),
        Row(
          children: [
            Expanded(
              child: _ResortField(
                icon: Icons.location_on_outlined,
                label: 'Where do you want to go?',
                value: 'Malé Atoll',
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _ResortField(
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
              child: _ResortField(
                icon: Icons.payments_outlined,
                label: 'Budget (per night)',
                value: 'Any Budget',
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _ResortField(
                icon: Icons.bed_outlined,
                label: 'Room & Meal Plan',
                value: '1 Room • All Meal Plans',
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _ResortField(
                icon: Icons.person_outline_rounded,
                label: 'Guests',
                value: '2 Adults • 0 Children',
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(child: _SearchResortsButton()),
          ],
        ),
      ],
    ),
  );
}

class _ResortField extends StatelessWidget {
  const _ResortField({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
    height: 54,
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.authBorder),
      borderRadius: BorderRadius.circular(AppSpacing.sm),
    ),
    child: Row(
      children: [
        Icon(icon, size: 20, color: AppColors.inputIcon),
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
                  fontSize: 8.5,
                  color: AppColors.inputIcon,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10.5,
                  color: AppColors.authNavy,
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

class _SearchResortsButton extends StatelessWidget {
  const _SearchResortsButton();

  @override
  Widget build(BuildContext context) => Container(
    height: 54,
    decoration: BoxDecoration(
      gradient: AppColors.dashboardActionGradient,
      borderRadius: BorderRadius.circular(AppSpacing.sm),
    ),
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Search Resorts',
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
    ),
  );
}

class _ResortGrid extends StatelessWidget {
  const _ResortGrid();

  static const resorts = <_ResortData>[
    _ResortData(
      'Sun Siyam Iru Veli',
      'Dhaalu Atoll, Maldives',
      1299,
      '4.8',
      'Best Seller',
      AppAssets.destinationRaa,
    ),
    _ResortData(
      'Conrad Maldives Rangali Island',
      'South Ari Atoll, Maldives',
      2499,
      '4.9',
      'Luxury Pick',
      AppAssets.dashboardHero,
    ),
    _ResortData(
      'Kudadoo Maldives',
      'Lhaviyani Atoll, Maldives',
      1799,
      '4.7',
      'Great Value',
      AppAssets.destinationBaa,
    ),
    _ResortData(
      'Kurumba Maldives',
      'North Malé Atoll, Maldives',
      899,
      '4.5',
      'Family Favorite',
      AppAssets.destinationMale,
    ),
    _ResortData(
      'Nova Maldives',
      'South Ari Atoll, Maldives',
      1199,
      '4.6',
      'New Arrival',
      AppAssets.destinationRaa,
    ),
    _ResortData(
      'Soneva Fushi',
      'Baa Atoll, Maldives',
      2899,
      '4.9',
      'Eco Friendly',
      AppAssets.destinationBaa,
    ),
  ];

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final count = constraints.maxWidth >= 450 ? 3 : 2;
      return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.smPlus),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: resorts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: count,
          crossAxisSpacing: AppSpacing.sm,
          mainAxisSpacing: AppSpacing.smPlus,
          childAspectRatio: count == 3 ? 0.68 : 0.72,
        ),
        itemBuilder: (_, index) => _ResortCard(data: resorts[index]),
      );
    },
  );
}

class _ResortCard extends StatelessWidget {
  const _ResortCard({required this.data});

  final _ResortData data;

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
                    color: AppColors.successBright,
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
                right: 7,
                top: 7,
                child: Icon(
                  Icons.favorite_border,
                  color: AppColors.white,
                  size: 21,
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
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '⌖ ${data.location}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.dashboardBlue,
                    fontSize: 8,
                  ),
                ),
                const SizedBox(height: 5),
                const Wrap(
                  spacing: 4,
                  children: [
                    _ResortTag('All Inclusive'),
                    _ResortTag('Water Villas'),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  '⭐ ${data.rating}  Excellent',
                  style: const TextStyle(
                    color: AppColors.inputIcon,
                    fontSize: 8.5,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'From\n\$${data.price} / Night',
                        maxLines: 2,
                        style: const TextStyle(
                          color: AppColors.dashboardBlue,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blueBorder),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        'View Details',
                        style: TextStyle(
                          color: AppColors.dashboardBlue,
                          fontSize: 7.5,
                          fontWeight: FontWeight.w700,
                        ),
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

class _ResortTag extends StatelessWidget {
  const _ResortTag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: AppColors.successSurface,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      label,
      style: const TextStyle(color: AppColors.successDark, fontSize: 7),
    ),
  );
}

class _ExpertBanner extends StatelessWidget {
  const _ExpertBanner();

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.smPlus),
    padding: const EdgeInsets.all(AppSpacing.md),
    decoration: BoxDecoration(
      color: AppColors.paleBlueSurface,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      border: Border.all(color: AppColors.blueBorder),
    ),
    child: const Row(
      children: [
        Icon(
          Icons.beach_access_rounded,
          color: AppColors.dashboardBlue,
          size: 34,
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Can't find the right resort?",
                style: TextStyle(
                  color: AppColors.authNavy,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Our travel experts will help you find the perfect resort.',
                style: TextStyle(color: AppColors.inputIcon, fontSize: 11),
              ),
            ],
          ),
        ),
        OutlinedButton(onPressed: null, child: Text('Speak to Expert')),
      ],
    ),
  );
}

class _ResortData {
  const _ResortData(
    this.name,
    this.location,
    this.price,
    this.rating,
    this.badge,
    this.image,
  );

  final String name;
  final String location;
  final int price;
  final String rating;
  final String badge;
  final String image;
}
