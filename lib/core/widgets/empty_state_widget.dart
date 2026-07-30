import 'package:flutter/material.dart';

import '../constants/app_strings.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({this.message = AppStrings.noData, super.key});

  final String message;

  @override
  Widget build(BuildContext context) => Center(child: Text(message));
}
