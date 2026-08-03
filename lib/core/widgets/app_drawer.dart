import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_assets.dart';
import '../theme/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static const _items = <_DrawerItem>[
    _DrawerItem('Home', Icons.home_outlined, '/home'),
    _DrawerItem(
      'Featured Resorts',
      Icons.hotel_outlined,
      '/home/featured-resorts',
    ),
    _DrawerItem(
      'Popular Destinations',
      Icons.location_on_outlined,
      '/home/popular-resorts',
    ),
    _DrawerItem('Activities', Icons.scuba_diving_outlined, '/home/activities'),
    _DrawerItem('Latest Blogs', Icons.article_outlined, '/home/latest-blogs'),
    _DrawerItem('Travel Guides', Icons.map_outlined, '/home/travel-guides'),
    _DrawerItem(
      'Search Holidays',
      Icons.travel_explore_rounded,
      '/home/search-holidays',
    ),
    _DrawerItem(
      'Recent Searches',
      Icons.history_rounded,
      '/home/recent-searches',
    ),
    _DrawerItem('Saved Searches', Icons.bookmark_border_rounded, '/search'),
  ];

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;
    return Drawer(
      width: MediaQuery.sizeOf(context).width.clamp(280, 330).toDouble(),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(22)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _DrawerHeader(onClose: () => Navigator.pop(context)),
            const Divider(height: 1, color: AppColors.divider),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
                itemCount: _items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 3),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  final selected = currentPath == item.path;
                  return ListTile(
                    selected: selected,
                    selectedTileColor: AppColors.blueTint,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    leading: Icon(
                      item.icon,
                      color: selected
                          ? AppColors.dashboardBlue
                          : AppColors.slate,
                    ),
                    title: Text(
                      item.label,
                      style: TextStyle(
                        color: selected
                            ? AppColors.dashboardBlue
                            : AppColors.authNavy,
                        fontSize: 14,
                        fontWeight: selected
                            ? FontWeight.w800
                            : FontWeight.w600,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                      color: selected
                          ? AppColors.dashboardBlue
                          : AppColors.inactive,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      if (!selected) context.go(item.path);
                    },
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 18),
              child: Row(
                children: [
                  Icon(
                    Icons.support_agent_rounded,
                    color: AppColors.dashboardBlue,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Need help? Talk to an Expert',
                      style: TextStyle(
                        color: AppColors.authNavy,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(18, 10, 8, 16),
    decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
    child: Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Image(
                image: AssetImage(AppAssets.brandLogo),
                height: 70,
                alignment: Alignment.centerLeft,
                fit: BoxFit.contain,
              ),
            ),
            IconButton(
              onPressed: onClose,
              icon: const Icon(Icons.close_rounded, color: Colors.white),
            ),
          ],
        ),
        const Row(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: AppColors.paleBlue,
              child: Icon(
                Icons.person_rounded,
                color: AppColors.authNavy,
                size: 28,
              ),
            ),
            SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'user@gmail.com',
                    style: TextStyle(color: Color(0xFFDCEBFF), fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _DrawerItem {
  const _DrawerItem(this.label, this.icon, this.path);
  final String label;
  final IconData icon;
  final String path;
}
