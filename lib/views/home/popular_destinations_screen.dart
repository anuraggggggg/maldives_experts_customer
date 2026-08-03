import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_drawer.dart';
import '../../core/widgets/network_image_widget.dart';
import 'widgets/booking_benefits.dart';
import 'widgets/dashboard_inner_header.dart';
import 'widgets/offer_banner.dart';
import 'widgets/section_header.dart';

class PopularDestinationsScreen extends StatelessWidget {
  const PopularDestinationsScreen({super.key});

  static const _items = <_DestinationData>[
    _DestinationData(
      'Malé Atoll',
      'The Heart of Maldives',
      'Home to the capital and some of the most luxurious resorts.',
      42,
      199,
      'Most Popular',
      Color(0xFF0754E8),
      'https://images.unsplash.com/photo-1540202404-a2f29016b523?auto=format&fit=crop&w=900&q=85',
    ),
    _DestinationData(
      'Baa Atoll',
      'UNESCO Biosphere Reserve',
      'Pristine beaches, vibrant marine life and unforgettable experiences.',
      35,
      249,
      'Best for Honeymoon',
      Color(0xFF8B32E8),
      'https://images.unsplash.com/photo-1514282401047-d79a71a590e8?auto=format&fit=crop&w=900&q=85',
    ),
    _DestinationData(
      'Raa Atoll',
      'Secluded & Serene',
      'A peaceful atoll offering privacy, luxury and breathtaking beauty.',
      28,
      229,
      'Luxury Escape',
      Color(0xFFE7A008),
      'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?auto=format&fit=crop&w=900&q=85',
    ),
    _DestinationData(
      'South Ari Atoll',
      'Perfect for Families',
      'Exciting activities, family resorts and amazing underwater adventures.',
      31,
      219,
      'Family Friendly',
      Color(0xFF18A957),
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=900&q=85',
    ),
    _DestinationData(
      'North Ari Atoll',
      'Diving & Marine Life',
      'Famous for whale sharks, manta rays and thrilling water sports.',
      27,
      239,
      'Adventure Hub',
      Color(0xFFFF7A19),
      'https://images.unsplash.com/photo-1530789253388-582c481c54b0?auto=format&fit=crop&w=900&q=85',
    ),
    _DestinationData(
      'Lhaviyani Atoll',
      'Undiscovered Paradise',
      'Crystal clear lagoons and untouched natural beauty.',
      18,
      209,
      'Hidden Gem',
      Color(0xFF12A9C6),
      'https://images.unsplash.com/photo-1510414842594-a61c69b5ae57?auto=format&fit=crop&w=900&q=85',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const AppDrawer(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              DashboardInnerHeader(
                title: 'Popular Destinations',
                subtitle: 'Explore the most loved places in the Maldives',
                backgroundImageUrl:
                    'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?auto=format&fit=crop&w=1800&q=90',
                onMenuPressed: () => scaffoldKey.currentState?.openDrawer(),
              ),
              Transform.translate(
                offset: const Offset(0, -18),
                child: const _SearchPanel(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.content),
                child: BookingBenefits(),
              ),
              const SizedBox(height: 18),
              const SectionHeader(
                title: 'Top Maldives Destinations',
                actionLabel: 'View All Destinations',
              ),
              const SizedBox(height: 8),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 720
                      ? 3
                      : constraints.maxWidth >= 480
                      ? 2
                      : 1;
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.content,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: columns == 1 ? 1.38 : .82,
                    ),
                    itemBuilder: (_, index) =>
                        _DestinationCard(data: _items[index]),
                  );
                },
              ),
              const SizedBox(height: 22),
              const OfferBanner(),
              const SizedBox(height: 22),
              const _WhyVisit(),
              const SizedBox(height: AppSpacing.bottomNavClearance),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchPanel extends StatelessWidget {
  const _SearchPanel();
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 14),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: AppColors.authNavy.withValues(alpha: .14),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: const Column(
      children: [_DestinationTabs(), SizedBox(height: 14), _SearchFields()],
    ),
  );
}

class _DestinationTabs extends StatelessWidget {
  const _DestinationTabs();
  static const _tabs = [
    (Icons.luggage_outlined, 'Packages'),
    (Icons.apartment_rounded, 'Resorts'),
    (Icons.location_on_outlined, 'Destinations'),
    (Icons.scuba_diving_outlined, 'Activities'),
    (Icons.sell_outlined, 'Offers'),
  ];
  @override
  Widget build(BuildContext context) => Row(
    children: _tabs.map((tab) {
      final active = tab.$2 == 'Destinations';
      return Expanded(
        child: Container(
          padding: const EdgeInsets.only(bottom: 11),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: active ? AppColors.dashboardBlue : AppColors.divider,
                width: active ? 2.5 : 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                tab.$1,
                size: 19,
                color: active ? AppColors.dashboardBlue : AppColors.navInactive,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: FittedBox(
                  child: Text(
                    tab.$2,
                    style: TextStyle(
                      color: active
                          ? AppColors.dashboardBlue
                          : AppColors.navInactive,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

class _SearchFields extends StatelessWidget {
  const _SearchFields();
  static const _fields = [
    _Field(
      Icons.location_on_outlined,
      'Where do you want to go?',
      'All Destinations',
    ),
    _Field(
      Icons.calendar_month_outlined,
      'Check-in – Check-out',
      '20 May 2025 – 24 May 2025',
    ),
    _Field(Icons.person_outline_rounded, 'Guests', '2 Adults • 0 Children'),
    _Field(Icons.payments_outlined, 'Budget (per person)', 'Any Budget'),
    _Field(Icons.bed_outlined, 'Room & Meal Plan', '1 Room • All Meal Plans'),
  ];
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth >= 650) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(child: _fields[0]),
                const SizedBox(width: 10),
                Expanded(child: _fields[1]),
                const SizedBox(width: 10),
                Expanded(child: _fields[2]),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _fields[3]),
                const SizedBox(width: 10),
                Expanded(child: _fields[4]),
                const SizedBox(width: 10),
                const Expanded(child: _ExploreButton()),
              ],
            ),
          ],
        );
      }
      return Column(
        children: [
          _fields[0],
          const SizedBox(height: 9),
          Row(
            children: [
              Expanded(child: _fields[1]),
              const SizedBox(width: 9),
              Expanded(child: _fields[2]),
            ],
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              Expanded(child: _fields[3]),
              const SizedBox(width: 9),
              Expanded(child: _fields[4]),
            ],
          ),
          const SizedBox(height: 10),
          const _ExploreButton(),
        ],
      );
    },
  );
}

class _Field extends StatelessWidget {
  const _Field(this.icon, this.label, this.value);
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Container(
    height: 58,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.authBorder),
      borderRadius: BorderRadius.circular(9),
    ),
    child: Row(
      children: [
        Icon(icon, color: AppColors.slate, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.slate, fontSize: 9),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.authNavy,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.slate,
          size: 18,
        ),
      ],
    ),
  );
}

class _ExploreButton extends StatelessWidget {
  const _ExploreButton();
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    height: 58,
    decoration: BoxDecoration(
      gradient: AppColors.dashboardActionGradient,
      borderRadius: BorderRadius.circular(9),
    ),
    child: TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(foregroundColor: Colors.white),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Explore Destinations',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
          ),
          SizedBox(width: 14),
          Icon(Icons.arrow_forward_rounded, size: 20),
        ],
      ),
    ),
  );
}

class _DestinationCard extends StatelessWidget {
  const _DestinationCard({required this.data});
  final _DestinationData data;
  @override
  Widget build(BuildContext context) => Container(
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.authBorder),
      boxShadow: [
        BoxShadow(
          color: AppColors.authNavy.withValues(alpha: .08),
          blurRadius: 12,
          offset: const Offset(0, 5),
        ),
      ],
    ),
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
                left: 10,
                top: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: data.badgeColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    data.badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const Positioned(
                right: 10,
                top: 9,
                child: Icon(
                  Icons.favorite_border_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: const TextStyle(
                    color: AppColors.authNavy,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.dashboardBlue,
                      size: 15,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        data.highlight,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.dashboardBlue,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  data.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.slate,
                    fontSize: 10.5,
                    height: 1.35,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${data.resorts} Resorts',
                      style: const TextStyle(
                        color: AppColors.slate,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'From ',
                      style: TextStyle(color: AppColors.slate, fontSize: 11),
                    ),
                    Text(
                      '\$${data.price}',
                      style: const TextStyle(
                        color: AppColors.dashboardBlue,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
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

class _WhyVisit extends StatelessWidget {
  const _WhyVisit();
  static const _items = [
    (Icons.waves_rounded, 'Crystal Clear Waters'),
    (Icons.scuba_diving_outlined, 'Rich Marine Life'),
    (Icons.beach_access_rounded, 'Luxury Resorts'),
    (Icons.wb_twilight_outlined, 'Breathtaking Sunsets'),
    (Icons.eco_outlined, 'Peace & Relaxation'),
  ];
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'Why Visit Maldives?',
          style: TextStyle(
            color: AppColors.authNavy,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      const SizedBox(height: 12),
      SizedBox(
        height: 82,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _items.length,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (_, index) {
            final item = _items[index];
            return SizedBox(
              width: 135,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.blueTint,
                    child: Icon(item.$1, color: AppColors.dashboardBlue),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.$2,
                      style: const TextStyle(
                        color: AppColors.authNavy,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}

class _DestinationData {
  const _DestinationData(
    this.name,
    this.highlight,
    this.description,
    this.resorts,
    this.price,
    this.badge,
    this.badgeColor,
    this.image,
  );
  final String name;
  final String highlight;
  final String description;
  final int resorts;
  final int price;
  final String badge;
  final Color badgeColor;
  final String image;
}
