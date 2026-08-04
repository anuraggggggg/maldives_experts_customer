import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';

enum ResortCollection { featured, popular }

class ResortCollectionScreen extends StatelessWidget {
  const ResortCollectionScreen({required this.collection, super.key});
  final ResortCollection collection;

  static const _featured = [
    _CardData(
      'Conrad Maldives Rangali Island',
      'South Ari Atoll',
      'From \$1,299 / night',
      '4.9',
      'assets/images/dashboard_hero.png',
    ),
    _CardData(
      'Sun Siyam Iru Veli',
      'Dhaalu Atoll',
      'From \$899 / night',
      '4.8',
      'assets/images/maldives3.png',
    ),
    _CardData(
      'Soneva Fushi',
      'Baa Atoll',
      'From \$1,749 / night',
      '4.9',
      'assets/images/maldives5.png',
    ),
    _CardData(
      'Kudadoo Maldives',
      'Lhaviyani Atoll',
      'From \$1,599 / night',
      '4.8',
      'assets/images/dashboard_hero.png',
    ),
  ];

  static const _popular = [
    _CardData(
      'Kurumba Maldives',
      'North Malé Atoll',
      'From \$649 / night',
      '4.7',
      'assets/images/maldives5.png',
    ),
    _CardData(
      'Nova Maldives',
      'South Ari Atoll',
      'From \$799 / night',
      '4.8',
      'assets/images/maldives3.png',
    ),
    _CardData(
      'Baros Maldives',
      'North Malé Atoll',
      'From \$999 / night',
      '4.9',
      'assets/images/dashboard_hero.png',
    ),
    _CardData(
      'Meeru Island Resort',
      'North Malé Atoll',
      'From \$529 / night',
      '4.6',
      'assets/images/maldives5.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final featured = collection == ResortCollection.featured;
    final items = featured ? _featured : _popular;
    return _DrawerPage(
      title: featured ? 'Featured Resorts' : 'Popular Resorts',
      subtitle: featured
          ? 'Handpicked luxury stays chosen by our experts'
          : 'The Maldives stays our travellers love most',
      child: Column(
        children: [
          _SearchBox(
            hint: 'Search ${featured ? 'featured' : 'popular'} resorts',
          ),
          const SizedBox(height: 15),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 13),
              child: _ResortResultCard(data: item),
            ),
          ),
        ],
      ),
    );
  }
}

class LatestBlogsScreen extends StatelessWidget {
  const LatestBlogsScreen({super.key});

  static const _blogs = [
    _CardData(
      '10 Best Maldives Resorts for 2026',
      'Resorts • 8 min read',
      'Discover exceptional island escapes for every kind of traveller.',
      '',
      'assets/images/dashboard_hero.png',
    ),
    _CardData(
      'The Perfect Maldives Honeymoon',
      'Romance • 6 min read',
      'A practical guide to planning an unforgettable tropical honeymoon.',
      '',
      'assets/images/maldives3.png',
    ),
    _CardData(
      'When Is the Best Time to Visit?',
      'Travel Tips • 5 min read',
      'Weather, prices and seasonal highlights explained simply.',
      '',
      'assets/images/maldives5.png',
    ),
  ];

  @override
  Widget build(BuildContext context) => _DrawerPage(
    title: 'Latest Blogs',
    subtitle: 'Ideas, inspiration and expert Maldives advice',
    child: Column(
      children: _blogs
          .map(
            (blog) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _ArticleCard(data: blog),
            ),
          )
          .toList(),
    ),
  );
}

class TravelGuidesScreen extends StatelessWidget {
  const TravelGuidesScreen({super.key});

  static const _guides = [
    _GuideData(
      Icons.calendar_month_outlined,
      'Best Time to Visit',
      'Understand the seasons, weather and best-value months.',
    ),
    _GuideData(
      Icons.flight_takeoff_rounded,
      'Getting to the Maldives',
      'Flights, airport arrivals, seaplanes and speedboats.',
    ),
    _GuideData(
      Icons.payments_outlined,
      'Budget & Currency',
      'Plan resort costs, transfers, tips and local payments.',
    ),
    _GuideData(
      Icons.luggage_outlined,
      'What to Pack',
      'Everything you need for an easy island holiday.',
    ),
    _GuideData(
      Icons.health_and_safety_outlined,
      'Travel Essentials',
      'Entry requirements, health and useful local advice.',
    ),
  ];

  @override
  Widget build(BuildContext context) => _DrawerPage(
    title: 'Travel Guides',
    subtitle: 'Everything you need for a smooth Maldives holiday',
    child: Column(
      children: _guides.map((guide) => _GuideCard(data: guide)).toList(),
    ),
  );
}

class SearchHolidaysScreen extends StatelessWidget {
  const SearchHolidaysScreen({super.key});

  @override
  Widget build(BuildContext context) => _DrawerPage(
    title: 'Search Holidays',
    subtitle: 'Find a Maldives escape made for you',
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: _PageDecor.card,
      child: Column(
        children: [
          const _SearchField(
            icon: Icons.location_on_outlined,
            label: 'Destination',
            value: 'All Maldives Atolls',
          ),
          const SizedBox(height: 11),
          const Row(
            children: [
              Expanded(
                child: _SearchField(
                  icon: Icons.calendar_month_outlined,
                  label: 'Check-in',
                  value: 'Select date',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _SearchField(
                  icon: Icons.calendar_month_outlined,
                  label: 'Check-out',
                  value: 'Select date',
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          const _SearchField(
            icon: Icons.people_outline_rounded,
            label: 'Guests',
            value: '2 Adults • 0 Children',
          ),
          const SizedBox(height: 11),
          const _SearchField(
            icon: Icons.payments_outlined,
            label: 'Budget',
            value: 'Any budget',
          ),
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.dashboardActionGradient,
              borderRadius: BorderRadius.circular(11),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.search_rounded),
                label: const Text('Search Holidays'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class RecentSearchesScreen extends StatelessWidget {
  const RecentSearchesScreen({super.key});

  @override
  Widget build(BuildContext context) => const _DrawerPage(
    title: 'Recent Searches',
    subtitle: 'Continue planning from where you left off',
    child: Column(
      children: [
        _RecentCard(
          title: 'Malé Atoll Resorts',
          details: '20 May – 24 May • 2 Adults',
          time: '2 hours ago',
        ),
        _RecentCard(
          title: 'All Inclusive Packages',
          details: '10 Jun – 15 Jun • 2 Adults',
          time: 'Yesterday',
        ),
        _RecentCard(
          title: 'Honeymoon Water Villas',
          details: '18 Jul – 24 Jul • 2 Adults',
          time: '3 days ago',
        ),
      ],
    ),
  );
}

class _DrawerPage extends StatelessWidget {
  const _DrawerPage({
    required this.title,
    required this.subtitle,
    required this.child,
  });
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.dark,
    child: Scaffold(
      backgroundColor: const Color(0xFFFCFDFE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        foregroundColor: AppColors.authNavy,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 115),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.authNavy,
                fontSize: 29,
                fontWeight: FontWeight.w800,
                letterSpacing: -.7,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(color: AppColors.slate, fontSize: 14),
            ),
            const SizedBox(height: 22),
            child,
          ],
        ),
      ),
    ),
  );
}

class _SearchBox extends StatelessWidget {
  const _SearchBox({required this.hint});
  final String hint;
  @override
  Widget build(BuildContext context) => TextField(
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: const Icon(Icons.search_rounded),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.authBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.authBorder),
      ),
    ),
  );
}

class _ResortResultCard extends StatelessWidget {
  const _ResortResultCard({required this.data});
  final _CardData data;
  @override
  Widget build(BuildContext context) => Container(
    height: 205 * MediaQuery.textScalerOf(context).scale(1),
    clipBehavior: Clip.antiAlias,
    decoration: _PageDecor.card,
    child: Row(
      children: [
        SizedBox(width: 128, child: Image.asset(data.image, fit: BoxFit.cover)),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: _PageText.cardTitle,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 15,
                      color: AppColors.slate,
                    ),
                    const SizedBox(width: 4),
                    Expanded(child: Text(data.meta, style: _PageText.meta)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 17,
                      color: AppColors.orange,
                    ),
                    const SizedBox(width: 3),
                    Text(data.extra, style: _PageText.meta),
                  ],
                ),
                const Spacer(),
                Text(
                  data.description,
                  style: const TextStyle(
                    color: AppColors.dashboardBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.data});
  final _CardData data;
  @override
  Widget build(BuildContext context) => Container(
    clipBehavior: Clip.antiAlias,
    decoration: _PageDecor.card,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 2.25,
          child: Image.asset(data.image, fit: BoxFit.cover),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.meta,
                style: const TextStyle(
                  color: AppColors.dashboardBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(data.title, style: _PageText.cardTitle),
              const SizedBox(height: 6),
              Text(data.description, style: _PageText.meta),
              const SizedBox(height: 10),
              const Text(
                'Read Article  →',
                style: TextStyle(
                  color: AppColors.dashboardBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _GuideCard extends StatelessWidget {
  const _GuideCard({required this.data});
  final _GuideData data;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 11),
    padding: const EdgeInsets.all(13),
    decoration: _PageDecor.card,
    child: Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.blueTint,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(data.icon, color: AppColors.dashboardBlue),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title, style: _PageText.cardTitle),
              const SizedBox(height: 4),
              Text(data.description, style: _PageText.meta),
            ],
          ),
        ),
        const Icon(Icons.chevron_right_rounded, color: AppColors.slate),
      ],
    ),
  );
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Container(
    height: 80 * MediaQuery.textScalerOf(context).scale(1),
    padding: const EdgeInsets.symmetric(horizontal: 11),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.authBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Icon(icon, color: AppColors.slate, size: 20),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: AppColors.slate, fontSize: 12),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.authNavy,
                  fontSize: 12,
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

class _RecentCard extends StatelessWidget {
  const _RecentCard({
    required this.title,
    required this.details,
    required this.time,
  });
  final String title;
  final String details;
  final String time;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 11),
    padding: const EdgeInsets.all(14),
    decoration: _PageDecor.card,
    child: Row(
      children: [
        Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            color: AppColors.blueTint,
            borderRadius: BorderRadius.circular(11),
          ),
          child: const Icon(
            Icons.history_rounded,
            color: AppColors.dashboardBlue,
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _PageText.cardTitle),
              const SizedBox(height: 4),
              Text(details, style: _PageText.meta),
              const SizedBox(height: 4),
              Text(
                time,
                style: const TextStyle(color: AppColors.inactive, fontSize: 12),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_forward_rounded,
            color: AppColors.dashboardBlue,
          ),
        ),
      ],
    ),
  );
}

class _CardData {
  const _CardData(
    this.title,
    this.meta,
    this.description,
    this.extra,
    this.image,
  );
  final String title;
  final String meta;
  final String description;
  final String extra;
  final String image;
}

class _GuideData {
  const _GuideData(this.icon, this.title, this.description);
  final IconData icon;
  final String title;
  final String description;
}

abstract final class _PageText {
  static const cardTitle = TextStyle(
    color: AppColors.authNavy,
    fontSize: 14.5,
    height: 1.2,
    fontWeight: FontWeight.w800,
  );
  static const meta = TextStyle(
    color: AppColors.slate,
    fontSize: 12,
    height: 1.35,
  );
}

abstract final class _PageDecor {
  static final card = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(13),
    border: Border.all(color: AppColors.authBorder),
    boxShadow: const [
      BoxShadow(color: Color(0x0A071445), blurRadius: 12, offset: Offset(0, 4)),
    ],
  );
}
