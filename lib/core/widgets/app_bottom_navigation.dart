import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_strings.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    required this.currentIndex,
    required this.onSelected,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onSelected;

  static const _items = <_NavigationItem>[
    _NavigationItem(AppStrings.home, Icons.home_outlined, Icons.home_rounded),
    _NavigationItem(
      AppStrings.myTrips,
      Icons.luggage_outlined,
      Icons.luggage_rounded,
    ),
    _NavigationItem(
      AppStrings.wishlist,
      Icons.favorite_border_rounded,
      Icons.favorite_rounded,
    ),
    _NavigationItem(
      AppStrings.enquiries,
      Icons.chat_bubble_outline_rounded,
      Icons.chat_bubble_rounded,
    ),
    _NavigationItem(
      AppStrings.profile,
      Icons.person_outline_rounded,
      Icons.person_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) => SafeArea(
    minimum: const EdgeInsets.fromLTRB(14, 0, 14, 8),
    child: Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: AppColors.authNavy.withValues(alpha: 0.14),
            blurRadius: 22,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: List.generate(
          _items.length,
          (index) => Expanded(
            child: _NavigationDestination(
              item: _items[index],
              selected: currentIndex == index,
              onTap: () {
                HapticFeedback.selectionClick();
                onSelected(index);
              },
            ),
          ),
        ),
      ),
    ),
  );
}

class _NavigationDestination extends StatelessWidget {
  const _NavigationDestination({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _NavigationItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    selected: selected,
    button: true,
    label: item.label,
    child: InkResponse(
      onTap: onTap,
      radius: 30,
      child: AnimatedContainer(
        duration: AppConstants.shortAnimationDuration,
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? item.selectedIcon : item.icon,
              color: selected ? AppColors.dashboardBlue : AppColors.navInactive,
              size: 25,
            ),
            const SizedBox(height: 2),
            Text(
              item.label,
              maxLines: 1,
              style: TextStyle(
                color: selected
                    ? AppColors.dashboardBlue
                    : AppColors.navInactive,
                fontSize: 10.5,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _NavigationItem {
  const _NavigationItem(this.label, this.icon, this.selectedIcon);

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
