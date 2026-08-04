import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

enum DashboardCategory {
  packages(AppStrings.packages, Icons.luggage_rounded, '/home'),
  resorts(AppStrings.resorts, Icons.apartment_rounded, '/home/resorts'),
  activities(
    AppStrings.activities,
    Icons.scuba_diving_rounded,
    '/home/activities',
  ),
  offers(AppStrings.offers, Icons.sell_outlined, '/home/offers');

  const DashboardCategory(this.label, this.icon, this.path);

  final String label;
  final IconData icon;
  final String? path;
}

class DashboardCategoryTabs extends StatelessWidget {
  const DashboardCategoryTabs({required this.selected, super.key});

  final DashboardCategory selected;

  @override
  Widget build(BuildContext context) => Row(
    children: DashboardCategory.values
        .map(
          (category) => Expanded(
            child: InkWell(
              onTap: category == selected || category.path == null
                  ? null
                  : () => context.go(category.path!),
              borderRadius: BorderRadius.circular(AppSpacing.sm),
              child: AnimatedContainer(
                duration: AppConstants.shortAnimationDuration,
                padding: const EdgeInsets.only(bottom: AppSpacing.smPlus),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: category == selected
                          ? AppColors.dashboardBlue
                          : AppColors.divider,
                      width: category == selected ? 2.5 : 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              category.icon,
                              size: 20,
                              color: category == selected
                                  ? AppColors.dashboardBlue
                                  : AppColors.navInactive,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              category.label,
                              maxLines: 1,
                              style: TextStyle(
                                color: category == selected
                                    ? AppColors.dashboardBlue
                                    : AppColors.navInactive,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .toList(growable: false),
  );
}
