import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../providers/home_provider.dart';

class TravelSearchCard extends StatelessWidget {
  const TravelSearchCard({super.key});

  static const _categories = <_SearchCategory>[
    _SearchCategory(AppStrings.packages, Icons.luggage_rounded),
    _SearchCategory(AppStrings.resorts, Icons.apartment_rounded),
    _SearchCategory(AppStrings.activities, Icons.scuba_diving_rounded),
    _SearchCategory(AppStrings.offers, Icons.sell_outlined),
  ];

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.regular),
    padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      boxShadow: [
        BoxShadow(
          color: AppColors.authNavy.withValues(alpha: 0.14),
          blurRadius: 22,
          offset: const Offset(0, 9),
        ),
      ],
    ),
    child: Column(
      children: [
        Selector<HomeProvider, int>(
          selector: (_, provider) => provider.selectedSearchCategory,
          builder: (context, selectedIndex, _) => Row(
            children: List.generate(
              _categories.length,
              (index) => Expanded(
                child: _CategoryTab(
                  category: _categories[index],
                  selected: selectedIndex == index,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    if (index == 1) {
                      context.go('/home/resorts');
                      return;
                    }
                    if (index == 3) {
                      context.go('/home/offers');
                      return;
                    }
                    if (index == 2) {
                      context.go('/home/activities');
                      return;
                    }
                    context.read<HomeProvider>().selectSearchCategory(index);
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.smPlus),
        const _SearchField(
          icon: Icons.location_on_outlined,
          label: AppStrings.destinationHint,
        ),
        const SizedBox(height: AppSpacing.sm),
        const Row(
          children: [
            Expanded(
              child: _SearchField(
                icon: Icons.calendar_month_outlined,
                label: AppStrings.dateHint,
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _SearchField(
                icon: Icons.person_outline_rounded,
                label: AppStrings.guestsHint,
                trailing: Icons.keyboard_arrow_down_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.smPlus),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppColors.dashboardActionGradient,
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: TextButton(
              onPressed: () => HapticFeedback.lightImpact(),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.sm),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.searchPackages,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: AppSpacing.xl),
                  Icon(Icons.arrow_forward_rounded, size: 23),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _CategoryTab extends StatelessWidget {
  const _CategoryTab({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final _SearchCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(AppSpacing.sm),
    child: AnimatedContainer(
      duration: AppConstants.shortAnimationDuration,
      padding: const EdgeInsets.only(bottom: AppSpacing.smPlus),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: selected ? AppColors.dashboardBlue : AppColors.divider,
            width: selected ? 2.5 : 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            category.icon,
            size: 20,
            color: selected ? AppColors.dashboardBlue : AppColors.navInactive,
          ),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              category.label,
              maxLines: 1,
              style: TextStyle(
                color: selected
                    ? AppColors.dashboardBlue
                    : AppColors.navInactive,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.icon, required this.label, this.trailing});

  final IconData icon;
  final String label;
  final IconData? trailing;

  @override
  Widget build(BuildContext context) => Container(
    height: 48,
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.smPlus),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppSpacing.sm),
      border: Border.all(color: AppColors.mediumGrey),
    ),
    child: Row(
      children: [
        Icon(icon, color: AppColors.navInactive, size: 21),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.navInactive,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (trailing case final trailing?)
          Icon(trailing, color: AppColors.inactive, size: 19),
      ],
    ),
  );
}

class _SearchCategory {
  const _SearchCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}
