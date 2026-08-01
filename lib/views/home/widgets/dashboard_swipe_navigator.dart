import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

enum DashboardPage {
  packages('/home'),
  resorts('/home/resorts'),
  activities('/home/activities'),
  offers('/home/offers');

  const DashboardPage(this.path);

  final String path;
}

class DashboardSwipeNavigator extends StatelessWidget {
  const DashboardSwipeNavigator({
    required this.currentPage,
    required this.child,
    super.key,
  });

  final DashboardPage currentPage;
  final Widget child;

  static const _minimumVelocity = 280.0;

  void _handleSwipe(BuildContext context, DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity.abs() < _minimumVelocity) return;

    final currentIndex = DashboardPage.values.indexOf(currentPage);
    final targetIndex = velocity < 0 ? currentIndex + 1 : currentIndex - 1;
    if (targetIndex < 0 || targetIndex >= DashboardPage.values.length) return;

    HapticFeedback.selectionClick();
    context.go(DashboardPage.values[targetIndex].path);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onHorizontalDragEnd: (details) => _handleSwipe(context, details),
    child: child,
  );
}
