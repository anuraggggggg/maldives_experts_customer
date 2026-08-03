import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/widgets/network_image_widget.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  int _selectedTab = 0;

  static const _tabs = [
    ('All', 24),
    ('Resorts', 10),
    ('Packages', 8),
    ('Destinations', 4),
    ('Activities', 2),
  ];

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.dark,
    child: Scaffold(
      backgroundColor: _WishColors.background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: _Header()),
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 4, 16, 18),
              sliver: SliverToBoxAdapter(child: _SavedSummary()),
            ),
            SliverToBoxAdapter(
              child: _CategoryTabs(
                tabs: _tabs,
                selected: _selectedTab,
                onSelected: (value) => setState(() => _selectedTab = value),
              ),
            ),
            const SliverToBoxAdapter(child: _SortAndFilter()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 115),
              sliver: SliverList.list(
                children: const [
                  _SectionHeader(title: 'Resorts (10)'),
                  SizedBox(height: 10),
                  _ResortCard(
                    image:
                        'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?auto=format&fit=crop&w=1000&q=85',
                    title: 'Conrad Maldives Rangali Island',
                    location: 'South Ari Atoll, Maldives',
                    rating: '4.8',
                    reviews: '1,256 reviews',
                    badge: 'Exceptional',
                    price: '\$1,299',
                    features: [
                      (Icons.houseboat_outlined, 'Overwater Villa'),
                      (Icons.card_travel_outlined, 'All Inclusive'),
                      (Icons.flight_takeoff_rounded, 'Free Seaplane'),
                    ],
                  ),
                  SizedBox(height: 12),
                  _ResortCard(
                    image:
                        'https://images.unsplash.com/photo-1514282401047-d79a71a590e8?auto=format&fit=crop&w=1000&q=85',
                    title: 'Sun Siyam Iru Veli',
                    location: 'Noonu Atoll, Maldives',
                    rating: '4.7',
                    reviews: '892 reviews',
                    badge: 'Excellent',
                    price: '\$899',
                    features: [
                      (Icons.houseboat_outlined, 'Overwater Villa'),
                      (Icons.card_travel_outlined, 'All Inclusive'),
                      (Icons.flight_takeoff_rounded, 'Seaplane Transfer'),
                    ],
                  ),
                  SizedBox(height: 22),
                  _SectionHeader(title: 'Packages (8)'),
                  SizedBox(height: 10),
                  _PackageCard(
                    image: 'assets/images/maldives5.png',
                    title: 'Maldives Tropical Escape',
                    details: '4 Nights / 5 Days  •  2 Adults',
                    price: '\$1,199',
                  ),
                  SizedBox(height: 12),
                  _PackageCard(
                    image: 'assets/images/dashboard_hero.png',
                    title: 'Romantic Maldives Getaway',
                    details: '5 Nights / 6 Days  •  2 Adults',
                    price: '\$1,699',
                  ),
                  SizedBox(height: 22),
                  _SectionHeader(title: 'Destinations (4)'),
                  SizedBox(height: 10),
                  _DestinationRow(),
                  SizedBox(height: 24),
                  _ExpertBanner(),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(18, 22, 10, 18),
    child: Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Wishlist', style: _WishText.pageTitle),
              SizedBox(height: 7),
              Text(
                'All your favorite places and experiences',
                style: _WishText.subtitle,
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded, size: 29),
              color: _WishColors.navy,
            ),
            const Positioned(right: 1, top: 0, child: _NotificationBadge()),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
          color: _WishColors.navy,
        ),
      ],
    ),
  );
}

class _NotificationBadge extends StatelessWidget {
  const _NotificationBadge();

  @override
  Widget build(BuildContext context) => Container(
    width: 20,
    height: 20,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      color: Color(0xFFE5262B),
      shape: BoxShape.circle,
    ),
    child: const Text(
      '3',
      style: TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

class _SavedSummary extends StatelessWidget {
  const _SavedSummary();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
    decoration: _WishDecor.card,
    child: const Row(
      children: [
        _SummaryTotal(),
        _SummaryItem(
          Icons.holiday_village_outlined,
          'Resorts',
          '10',
          Color(0xFFEAF2FF),
          _WishColors.blue,
        ),
        _SummaryItem(
          Icons.beach_access_rounded,
          'Packages',
          '8',
          Color(0xFFEAF8EF),
          Color(0xFF159757),
        ),
        _SummaryItem(
          Icons.landscape_outlined,
          'Destinations',
          '4',
          Color(0xFFF1EDFF),
          Color(0xFF6946E8),
        ),
        _SummaryItem(
          Icons.scuba_diving_outlined,
          'Activities',
          '2',
          Color(0xFFFFF1E6),
          Color(0xFFFF7A19),
        ),
      ],
    ),
  );
}

class _SummaryTotal extends StatelessWidget {
  const _SummaryTotal();

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: _WishColors.border)),
      ),
      child: const Column(
        children: [
          Text('Total Saved', style: _WishText.smallLabel),
          SizedBox(height: 2),
          Text(
            '24',
            style: TextStyle(
              color: _WishColors.blue,
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text('Items', style: _WishText.smallLabel),
        ],
      ),
    ),
  );
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem(
    this.icon,
    this.label,
    this.count,
    this.background,
    this.color,
  );
  final IconData icon;
  final String label;
  final String count;
  final Color background;
  final Color color;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 5),
        FittedBox(child: Text(label, style: _WishText.tinyLabel)),
        Text(
          count,
          style: const TextStyle(
            color: _WishColors.navy,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}

class _CategoryTabs extends StatelessWidget {
  const _CategoryTabs({
    required this.tabs,
    required this.selected,
    required this.onSelected,
  });
  final List<(String, int)> tabs;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) => Container(
    height: 58,
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: _WishColors.border)),
    ),
    child: Row(
      children: List.generate(tabs.length, (index) {
        final active = index == selected;
        return Expanded(
          child: InkWell(
            onTap: () => onSelected(index),
            child: Stack(
              alignment: Alignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
                    child: Text(
                      '${tabs[index].$1} (${tabs[index].$2})',
                      style: TextStyle(
                        color: active ? _WishColors.blue : _WishColors.muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                if (active)
                  const Positioned(
                    bottom: 0,
                    left: 8,
                    right: 8,
                    child: ColoredBox(
                      color: _WishColors.blue,
                      child: SizedBox(height: 2.5),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    ),
  );
}

class _SortAndFilter extends StatelessWidget {
  const _SortAndFilter();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
    child: Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            iconAlignment: IconAlignment.end,
            icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
            label: const FittedBox(child: Text('Sort by: Recently Added')),
            style: _WishButton.outlined,
          ),
        ),
        const SizedBox(width: 10),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.filter_alt_outlined, size: 19),
          label: const Text('Filter'),
          style: _WishButton.outlined,
        ),
      ],
    ),
  );
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: Text(title, style: _WishText.sectionTitle)),
      TextButton(
        onPressed: () {},
        child: const Row(
          children: [
            Text('View All'),
            SizedBox(width: 3),
            Icon(Icons.chevron_right_rounded, size: 20),
          ],
        ),
      ),
    ],
  );
}

class _ResortCard extends StatelessWidget {
  const _ResortCard({
    required this.image,
    required this.title,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.badge,
    required this.price,
    required this.features,
  });
  final String image;
  final String title;
  final String location;
  final String rating;
  final String reviews;
  final String badge;
  final String price;
  final List<(IconData, String)> features;

  @override
  Widget build(BuildContext context) => Container(
    clipBehavior: Clip.antiAlias,
    decoration: _WishDecor.card,
    child: LayoutBuilder(
      builder: (context, constraints) {
        final imageWidth = constraints.maxWidth * .36;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _WishImage(image: image, width: imageWidth),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CardTitle(title: title),
                      const SizedBox(height: 5),
                      _IconText(Icons.location_on_outlined, location),
                      const SizedBox(height: 7),
                      Wrap(
                        spacing: 5,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFFA900),
                            size: 17,
                          ),
                          Text('$rating  ($reviews)', style: _WishText.meta),
                          _StatusBadge(badge),
                        ],
                      ),
                      const SizedBox(height: 11),
                      Row(
                        children: features
                            .map(
                              (feature) => Expanded(
                                child: _Feature(
                                  icon: feature.$1,
                                  label: feature.$2,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const Spacer(),
                      const SizedBox(height: 10),
                      _PriceRow(price: price, suffix: '/ night'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

class _PackageCard extends StatelessWidget {
  const _PackageCard({
    required this.image,
    required this.title,
    required this.details,
    required this.price,
  });
  final String image;
  final String title;
  final String details;
  final String price;

  @override
  Widget build(BuildContext context) => Container(
    clipBehavior: Clip.antiAlias,
    decoration: _WishDecor.card,
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _WishImage(
            image: image,
            width: MediaQuery.sizeOf(context).width * .34,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CardTitle(title: title),
                  const SizedBox(height: 5),
                  Text(details, style: _WishText.meta),
                  const SizedBox(height: 15),
                  const Row(
                    children: [
                      Expanded(
                        child: _Feature(
                          icon: Icons.flight_takeoff_rounded,
                          label: 'Flights',
                        ),
                      ),
                      Expanded(
                        child: _Feature(
                          icon: Icons.hotel_outlined,
                          label: 'Hotel',
                        ),
                      ),
                      Expanded(
                        child: _Feature(
                          icon: Icons.restaurant_outlined,
                          label: 'Meals',
                        ),
                      ),
                      Expanded(
                        child: _Feature(
                          icon: Icons.airport_shuttle_outlined,
                          label: 'Transfers',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _PriceRow(price: price, suffix: '/ person'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _WishImage extends StatelessWidget {
  const _WishImage({required this.image, required this.width});
  final String image;
  final double width;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    child: Stack(
      fit: StackFit.expand,
      children: [
        if (image.startsWith('http'))
          NetworkImageWidget(url: image)
        else
          Image.asset(image, fit: BoxFit.cover),
        Positioned(
          right: 9,
          top: 9,
          child: Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite_rounded,
              color: Color(0xFFEF3340),
              size: 20,
            ),
          ),
        ),
      ],
    ),
  );
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: _WishText.cardTitle,
        ),
      ),
      const Icon(Icons.more_vert_rounded, size: 21, color: _WishColors.navy),
    ],
  );
}

class _IconText extends StatelessWidget {
  const _IconText(this.icon, this.text);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, size: 15, color: _WishColors.muted),
      const SizedBox(width: 5),
      Expanded(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: _WishText.meta,
        ),
      ),
    ],
  );
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: const Color(0xFFE5F8E9),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFF07883A),
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _Feature extends StatelessWidget {
  const _Feature({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Icon(icon, size: 19, color: _WishColors.muted),
      const SizedBox(height: 3),
      Text(
        label,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: _WishColors.muted,
          fontSize: 8.5,
          height: 1.15,
        ),
      ),
    ],
  );
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.price, required this.suffix});
  final String price;
  final String suffix;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        children: [
          const Text('From ', style: _WishText.meta),
          Text(
            price,
            style: const TextStyle(
              color: _WishColors.blue,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          Flexible(
            child: Text(
              ' $suffix',
              overflow: TextOverflow.ellipsis,
              style: _WishText.meta,
            ),
          ),
        ],
      ),
      const SizedBox(height: 6),
      Align(
        alignment: Alignment.centerRight,
        child: OutlinedButton(
          onPressed: () {},
          style: _WishButton.details,
          child: const Text('View Details'),
        ),
      ),
    ],
  );
}

class _DestinationRow extends StatelessWidget {
  const _DestinationRow();

  static const _destinations = [
    (
      'Malé Atoll',
      '56 Resorts',
      'https://images.unsplash.com/photo-1540202404-a2f29016b523?auto=format&fit=crop&w=700&q=85',
    ),
    (
      'Baa Atoll',
      '45 Resorts',
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=700&q=85',
    ),
    (
      'Raa Atoll',
      '38 Resorts',
      'https://images.unsplash.com/photo-1510414842594-a61c69b5ae57?auto=format&fit=crop&w=700&q=85',
    ),
    (
      'Ari Atoll',
      '62 Resorts',
      'https://images.unsplash.com/photo-1530789253388-582c481c54b0?auto=format&fit=crop&w=700&q=85',
    ),
  ];

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: _destinations
        .map(
          (item) => Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 7),
              child: _DestinationCard(
                name: item.$1,
                resorts: item.$2,
                image: item.$3,
              ),
            ),
          ),
        )
        .toList(),
  );
}

class _DestinationCard extends StatelessWidget {
  const _DestinationCard({
    required this.name,
    required this.resorts,
    required this.image,
  });
  final String name;
  final String resorts;
  final String image;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AspectRatio(
        aspectRatio: 1.3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: Stack(
            fit: StackFit.expand,
            children: [
              NetworkImageWidget(url: image),
              const Positioned(
                right: 5,
                top: 5,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.favorite_rounded,
                    color: Color(0xFFEF3340),
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 7),
      Text(
        name,
        maxLines: 1,
        style: const TextStyle(
          color: _WishColors.navy,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
      Text(
        resorts,
        style: const TextStyle(color: _WishColors.muted, fontSize: 10),
      ),
    ],
  );
}

class _ExpertBanner extends StatelessWidget {
  const _ExpertBanner();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: const Color(0xFFF3F7FF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFCFE0FF)),
    ),
    child: Row(
      children: [
        const CircleAvatar(
          backgroundColor: Color(0xFFE3EEFF),
          child: Icon(Icons.support_agent_rounded, color: _WishColors.blue),
        ),
        const SizedBox(width: 11),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Need help planning your dream trip?',
                style: TextStyle(
                  color: _WishColors.blue,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Our Maldives Experts are here for you 24/7.',
                style: _WishText.meta,
              ),
            ],
          ),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.phone_outlined, size: 17),
          label: const Text('Talk to Expert'),
          style: _WishButton.details,
        ),
      ],
    ),
  );
}

abstract final class _WishColors {
  static const navy = Color(0xFF071445);
  static const blue = AppColors.dashboardBlue;
  static const muted = Color(0xFF5D6482);
  static const border = Color(0xFFE4E7EF);
  static const background = Color(0xFFFCFDFE);
}

abstract final class _WishText {
  static const pageTitle = TextStyle(
    color: _WishColors.navy,
    fontSize: 30,
    height: 1.1,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.8,
  );
  static const subtitle = TextStyle(color: _WishColors.muted, fontSize: 14);
  static const sectionTitle = TextStyle(
    color: _WishColors.navy,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
  static const cardTitle = TextStyle(
    color: _WishColors.navy,
    fontSize: 15.5,
    height: 1.15,
    fontWeight: FontWeight.w800,
  );
  static const smallLabel = TextStyle(
    color: _WishColors.navy,
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );
  static const tinyLabel = TextStyle(
    color: _WishColors.navy,
    fontSize: 9.5,
    fontWeight: FontWeight.w600,
  );
  static const meta = TextStyle(color: _WishColors.muted, fontSize: 10.5);
}

abstract final class _WishDecor {
  static final card = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(13),
    border: Border.all(color: _WishColors.border),
    boxShadow: const [
      BoxShadow(color: Color(0x0D071445), blurRadius: 12, offset: Offset(0, 4)),
    ],
  );
}

abstract final class _WishButton {
  static final outlined = OutlinedButton.styleFrom(
    foregroundColor: _WishColors.muted,
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
    side: const BorderSide(color: _WishColors.border),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
  );

  static final details = OutlinedButton.styleFrom(
    foregroundColor: _WishColors.blue,
    minimumSize: const Size(0, 34),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    side: const BorderSide(color: _WishColors.blue),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    textStyle: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700),
  );
}
