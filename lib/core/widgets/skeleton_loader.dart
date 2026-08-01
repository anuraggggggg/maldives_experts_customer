import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../constants/app_constants.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({
    required this.height,
    this.width = double.infinity,
    this.borderRadius = AppSpacing.radius,
    super.key,
  });

  final double height;
  final double width;
  final double borderRadius;

  @override
  Widget build(BuildContext context) => RepaintBoundary(
    child: Shimmer.fromColors(
      baseColor: AppColors.authBorder,
      highlightColor: AppColors.white,
      period: AppConstants.shimmerDuration,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    ),
  );
}
