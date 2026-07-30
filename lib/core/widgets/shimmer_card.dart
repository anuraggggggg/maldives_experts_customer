import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_colors.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: AppColors.sand,
    highlightColor: AppColors.white,
    child: const Card(child: SizedBox(height: 140, width: double.infinity)),
  );
}
