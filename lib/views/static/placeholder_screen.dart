import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: const Center(child: Text(AppStrings.comingSoon)),
  );
}
