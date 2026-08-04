import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../models/destination.dart';
import 'section_header.dart';

class DestinationSection extends StatelessWidget {
  const DestinationSection({super.key});

  static const _destinations = <Destination>[
    Destination(
      name: 'Malé Atoll',
      resortCount: 42,
      startingPrice: 199,
      imagePath: AppAssets.destinationMale,
      badge: 'Most Popular',
    ),
    Destination(
      name: 'Baa Atoll',
      resortCount: 35,
      startingPrice: 249,
      imagePath: AppAssets.destinationBaa,
    ),
    Destination(
      name: 'Raa Atoll',
      resortCount: 28,
      startingPrice: 229,
      imagePath: AppAssets.destinationRaa,
    ),
  ];

  @override
  Widget build(BuildContext context) => Column(
    children: [
      SectionHeader(
        title: AppStrings.popularDestinations,
        actionLabel: AppStrings.viewAll,
        onAction: () {},
      ),
      const SizedBox(height: AppSpacing.xs),
      SizedBox(
        height: 170 * MediaQuery.textScalerOf(context).scale(1),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.regular),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: _destinations.length,
          separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.smPlus),
          itemBuilder: (_, index) =>
              DestinationCard(destination: _destinations[index]),
        ),
      ),
    ],
  );
}

class DestinationCard extends StatelessWidget {
  const DestinationCard({required this.destination, super.key});

  final Destination destination;

  @override
  Widget build(BuildContext context) => Container(
    width: 160,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.09),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: 'destination-${destination.name}',
          child: Stack(
            children: [
              Image.asset(
                destination.imagePath,
                width: double.infinity,
                height: 88,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
              ),
              if (destination.badge case final badge?)
                Positioned(
                  left: AppSpacing.sm,
                  top: AppSpacing.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.dashboardBlue,
                      borderRadius: BorderRadius.circular(AppSpacing.xs),
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 9, 10, 0),
          child: Text(
            destination.name,
            style: AppTextStyles.dashboardCardTitle,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${destination.resortCount} Resorts',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.dashboardCaption,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'From \$${destination.startingPrice}',
                    maxLines: 1,
                    style: const TextStyle(
                      color: AppColors.dashboardBlue,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
