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

class ResortsScreen extends StatelessWidget {
  const ResortsScreen({super.key});

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
          currentPage: DashboardPage.resorts,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                DashboardInnerHeader(
                  title: 'Featured Resorts',
                  subtitle:
                      'Handpicked luxury resorts for your perfect stay\nin the Maldives',
                  backgroundImageUrl:
                      'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?auto=format&fit=crop&w=1800&q=90',
                  onMenuPressed: () => scaffoldKey.currentState?.openDrawer(),
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
        _ResponsiveResortFields(),
      ],
    ),
  );
}

class _ResponsiveResortFields extends StatelessWidget {
  const _ResponsiveResortFields();

  static const fields = [
    _ResortField(
      icon: Icons.location_on_outlined,
      label: 'Where do you want to go?',
      value: 'Malé Atoll',
    ),
    _ResortField(
      icon: Icons.calendar_month_outlined,
      label: 'Check-in – Check-out',
      value: '20 May 2025 – 24 May 2025',
    ),
    _ResortField(
      icon: Icons.person_outline_rounded,
      label: 'Guests',
      value: '2 Adults • 0 Children',
    ),
    _ResortField(
      icon: Icons.payments_outlined,
      label: 'Budget (per night)',
      value: 'Any Budget',
    ),
    _ResortField(
      icon: Icons.bed_outlined,
      label: 'Room & Meal Plan',
      value: '1 Room • All Meal Plans',
    ),
  ];

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth >= 650) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(child: fields[0]),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: fields[1]),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: fields[2]),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(child: fields[3]),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: fields[4]),
                const SizedBox(width: AppSpacing.sm),
                const Expanded(child: _SearchResortsButton()),
              ],
            ),
          ],
        );
      }
      return Column(
        children: [
          fields[0],
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(child: fields[1]),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: fields[2]),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(child: fields[3]),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: fields[4]),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const _SearchResortsButton(),
        ],
      );
    },
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
                  fontSize: 12,
                  color: AppColors.inputIcon,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
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
      'https://images.unsplash.com/photo-1540202404-a2f29016b523?auto=format&fit=crop&w=900&q=85',
    ),
    _ResortData(
      'Conrad Maldives Rangali Island',
      'South Ari Atoll, Maldives',
      2499,
      '4.9',
      'Luxury Pick',
      'https://images.unsplash.com/photo-1514282401047-d79a71a590e8?auto=format&fit=crop&w=900&q=85',
    ),
    _ResortData(
      'Kudadoo Maldives',
      'Lhaviyani Atoll, Maldives',
      1799,
      '4.7',
      'Great Value',
      'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=900&q=85',
    ),
    _ResortData(
      'Kurumba Maldives',
      'North Malé Atoll, Maldives',
      899,
      '4.5',
      'Family Favorite',
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=900&q=85',
    ),
    _ResortData(
      'Nova Maldives',
      'South Ari Atoll, Maldives',
      1199,
      '4.6',
      'New Arrival',
      'https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=900&q=85',
    ),
    _ResortData(
      'Soneva Fushi',
      'Baa Atoll, Maldives',
      2899,
      '4.9',
      'Eco Friendly',
      'https://images.unsplash.com/photo-1530789253388-582c481c54b0?auto=format&fit=crop&w=900&q=85',
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
          mainAxisExtent: count == 3 ? 402 : 372,
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
                    color: AppColors.successBright,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    data.badge,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
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
                  size: 25,
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
                    fontSize: 16,
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
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
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
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
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
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.dashboardBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
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
      style: const TextStyle(
        color: AppColors.successDark,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
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
                style: TextStyle(color: AppColors.inputIcon, fontSize: 12),
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
