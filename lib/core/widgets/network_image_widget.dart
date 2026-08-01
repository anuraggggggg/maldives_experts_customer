import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'skeleton_loader.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({
    required this.url,
    this.fit = BoxFit.cover,
    super.key,
  });

  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
    imageUrl: url,
    fit: fit,
    placeholder: (_, __) =>
        const SkeletonLoader(height: double.infinity, borderRadius: 0),
    errorWidget: (_, __, ___) => const Icon(Icons.broken_image_outlined),
  );
}
