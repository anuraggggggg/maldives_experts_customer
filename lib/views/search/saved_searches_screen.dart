import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/route_names.dart';
import '../../core/theme/app_colors.dart';

class SavedSearchesScreen extends StatefulWidget {
  const SavedSearchesScreen({super.key});

  @override
  State<SavedSearchesScreen> createState() => _SavedSearchesScreenState();
}

class _SavedSearchesScreenState extends State<SavedSearchesScreen> {
  int _selectedTab = 0;
  bool _showTip = true;

  static const _searches = [
    _SavedSearch(
      title: 'Malé Atoll, Maldives',
      location: 'Malé Atoll',
      date: '20 May – 24 May 2025',
      guests: '2 Adults, 0 Children',
      preferences: 'Any Budget  •  All Meal Plans',
      saved: 'Saved 2 hours ago',
      image: 'assets/images/dashboard_hero.png',
    ),
    _SavedSearch(
      title: 'Baa Atoll, Maldives',
      location: 'Baa Atoll',
      date: '15 Jun – 20 Jun 2025',
      guests: '2 Adults, 1 Child',
      preferences: r'Budget: $1,000 - $2,000  •  All Inclusive',
      saved: 'Saved 1 day ago',
      image: 'assets/images/maldives5.png',
    ),
    _SavedSearch(
      title: 'Conrad Maldives Rangali Island',
      location: 'South Ari Atoll, Maldives',
      date: '10 Jul – 15 Jul 2025',
      guests: '2 Adults, 0 Children',
      preferences: 'All Meal Plans  •  Water Villas',
      saved: 'Saved 3 days ago',
      image: 'assets/images/maldives3.png',
    ),
    _SavedSearch(
      title: 'Lhaviyani Atoll, Maldives',
      location: 'Lhaviyani Atoll',
      date: '5 Aug – 10 Aug 2025',
      guests: '2 Adults, 2 Children',
      preferences: r'Budget: $2,000 - $3,000  •  Breakfast',
      saved: 'Saved 5 days ago',
      image: 'assets/images/login_hero.png',
    ),
    _SavedSearch(
      title: 'Sun Siyam Iru Veli',
      location: 'Dhaalu Atoll, Maldives',
      date: '1 Sep – 6 Sep 2025',
      guests: '2 Adults, 0 Children',
      preferences: 'All Inclusive  •  Luxury',
      saved: 'Saved 1 week ago',
      image: 'assets/images/dashboard_hero.png',
    ),
  ];

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.dark,
    child: Scaffold(
      backgroundColor: const Color(0xFFFCFDFE),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: _SearchHeader()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search destinations, resorts, packages...',
                          hintStyle: const TextStyle(fontSize: 12),
                          prefixIcon: const Icon(Icons.search_rounded),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: _SearchColors.border,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: _SearchColors.border,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton.icon(
                      onPressed: () => context.pushNamed(RouteNames.filters),
                      icon: const Icon(Icons.tune_rounded, size: 20),
                      label: const Text('Filters'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _SearchColors.blue,
                        side: const BorderSide(color: Color(0xFFBCD0FF)),
                        minimumSize: const Size(94, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _SearchTabs(
                selected: _selectedTab,
                onSelected: (value) => setState(() => _selectedTab = value),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
              sliver: SliverList.list(
                children: [
                  if (_showTip) ...[
                    _InfoBanner(
                      onClose: () => setState(() => _showTip = false),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          '5 Saved Searches',
                          style: _SearchText.section,
                        ),
                      ),
                      const Text('Sort by:', style: _SearchText.caption),
                      const SizedBox(width: 7),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: _SearchColors.border),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: 'Recently Saved',
                            items: const [
                              DropdownMenuItem(
                                value: 'Recently Saved',
                                child: Text('Recently Saved'),
                              ),
                              DropdownMenuItem(
                                value: 'Oldest',
                                child: Text('Oldest'),
                              ),
                            ],
                            onChanged: (_) {},
                            style: const TextStyle(
                              color: _SearchColors.muted,
                              fontSize: 12,
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ..._searches.map(
                    (search) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _SavedSearchCard(search: search),
                    ),
                  ),
                  const _ManageAlertsCard(),
                  const SizedBox(height: 10),
                  const _ClearSearchesCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _SearchHeader extends StatelessWidget {
  const _SearchHeader();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
    child: Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Saved Searches', style: _SearchText.title),
              SizedBox(height: 3),
              Text(
                'Quick access to your saved holiday searches',
                style: _SearchText.caption,
              ),
            ],
          ),
        ),
        Image.asset(
          'assets/images/maldives_logo.png',
          width: 95,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 8),
        const CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xFFE8EEF8),
          child: Icon(Icons.person_rounded, color: _SearchColors.navy),
        ),
      ],
    ),
  );
}

class _SearchTabs extends StatelessWidget {
  const _SearchTabs({required this.selected, required this.onSelected});
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) => Container(
    height: 54,
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: _SearchColors.border)),
    ),
    child: Row(
      children: [
        _Tab(
          icon: Icons.bookmark_border_rounded,
          label: 'My Saved Searches',
          active: selected == 0,
          onTap: () => onSelected(0),
        ),
        _Tab(
          icon: Icons.notifications_none_rounded,
          label: 'Search Alerts',
          active: selected == 1,
          onTap: () => onSelected(1),
        ),
      ],
    ),
  );
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Expanded(
    child: InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: active ? _SearchColors.blue : _SearchColors.muted,
                    size: 20,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    label,
                    maxLines: 1,
                    style: TextStyle(
                      color: active ? _SearchColors.blue : _SearchColors.muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (active)
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 2.5,
                child: ColoredBox(color: _SearchColors.blue),
              ),
            ),
        ],
      ),
    ),
  );
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: const Color(0xFFF0F5FF),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFDCE7FF)),
    ),
    child: Row(
      children: [
        const CircleAvatar(
          backgroundColor: Color(0xFFE0EAFE),
          child: Icon(Icons.bookmark_rounded, color: _SearchColors.blue),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Save your favorite searches and quickly find the best holidays',
                style: TextStyle(
                  color: _SearchColors.navy,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'You can create search alerts to get notified of new deals.',
                style: _SearchText.caption,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onClose,
          icon: const Icon(
            Icons.close_rounded,
            color: _SearchColors.blue,
            size: 20,
          ),
        ),
      ],
    ),
  );
}

class _SavedSearchCard extends StatelessWidget {
  const _SavedSearchCard({required this.search});
  final _SavedSearch search;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(9),
    decoration: _SearchDecor.card,
    child: Row(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                search.image,
                width: 112,
                height: 112,
                fit: BoxFit.cover,
              ),
            ),
            const Positioned(
              right: 7,
              top: 7,
              child: Icon(
                Icons.favorite_border_rounded,
                color: Colors.white,
                size: 24,
                shadows: [Shadow(color: Colors.black38, blurRadius: 5)],
              ),
            ),
          ],
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                search.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: _SearchText.cardTitle,
              ),
              const SizedBox(height: 7),
              _Line(Icons.location_on_outlined, search.location),
              _Line(Icons.calendar_month_outlined, search.date),
              _Line(Icons.person_outline_rounded, search.guests),
              _Line(Icons.account_balance_wallet_outlined, search.preferences),
            ],
          ),
        ),
        const SizedBox(width: 7),
        SizedBox(
          width: 94,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                search.saved,
                style: const TextStyle(
                  color: _SearchColors.muted,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 19),
              _MiniButton(
                icon: Icons.search_rounded,
                label: 'Search Again',
                onPressed: () {},
              ),
              const SizedBox(height: 7),
              _MiniButton(
                icon: Icons.notifications_none_rounded,
                label: 'Create Alert',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _Line extends StatelessWidget {
  const _Line(this.icon, this.text);
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Icon(icon, color: _SearchColors.blue, size: 15),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _SearchText.caption,
          ),
        ),
      ],
    ),
  );
}

class _MiniButton extends StatelessWidget {
  const _MiniButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 94,
    height: 32,
    child: OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 15),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        foregroundColor: _SearchColors.navy,
        side: const BorderSide(color: _SearchColors.border),
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
      ),
    ),
  );
}

class _ManageAlertsCard extends StatelessWidget {
  const _ManageAlertsCard();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: const Color(0xFFF0FBF8),
      border: Border.all(color: const Color(0xFFBFE5D9)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: const Row(
      children: [
        CircleAvatar(
          backgroundColor: Color(0xFFDDF5EC),
          child: Icon(
            Icons.notifications_none_rounded,
            color: Color(0xFF08765A),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get price alerts for your saved searches',
                style: TextStyle(
                  color: Color(0xFF075E4A),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              Text(
                "We'll notify you when prices drop or new offers match your searches.",
                style: _SearchText.caption,
              ),
            ],
          ),
        ),
        Icon(Icons.chevron_right_rounded, color: Color(0xFF08765A)),
      ],
    ),
  );
}

class _ClearSearchesCard extends StatelessWidget {
  const _ClearSearchesCard();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFBFB),
      border: Border.all(color: const Color(0xFFFFD2D2)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: const Row(
      children: [
        Icon(Icons.delete_outline_rounded, color: Colors.red),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Clear All Saved Searches',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              Text(
                'This will remove all your saved searches',
                style: _SearchText.caption,
              ),
            ],
          ),
        ),
        Icon(Icons.chevron_right_rounded, color: Colors.red),
      ],
    ),
  );
}

class _SavedSearch {
  const _SavedSearch({
    required this.title,
    required this.location,
    required this.date,
    required this.guests,
    required this.preferences,
    required this.saved,
    required this.image,
  });
  final String title;
  final String location;
  final String date;
  final String guests;
  final String preferences;
  final String saved;
  final String image;
}

abstract final class _SearchColors {
  static const navy = Color(0xFF0A174D);
  static const blue = AppColors.dashboardBlue;
  static const muted = Color(0xFF616880);
  static const border = Color(0xFFE0E4EC);
}

abstract final class _SearchText {
  static const title = TextStyle(
    color: _SearchColors.navy,
    fontSize: 24,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.4,
  );
  static const section = TextStyle(
    color: _SearchColors.navy,
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
  static const cardTitle = TextStyle(
    color: _SearchColors.navy,
    fontSize: 14,
    fontWeight: FontWeight.w800,
  );
  static const caption = TextStyle(color: _SearchColors.muted, fontSize: 12);
}

abstract final class _SearchDecor {
  static final card = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(11),
    border: Border.all(color: _SearchColors.border),
    boxShadow: const [
      BoxShadow(color: Color(0x0B0A174D), blurRadius: 12, offset: Offset(0, 3)),
    ],
  );
}
