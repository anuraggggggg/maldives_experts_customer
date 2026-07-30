import 'package:flutter/material.dart';

class PaginatedListView extends StatelessWidget {
  const PaginatedListView({
    required this.itemCount,
    required this.itemBuilder,
    required this.onLoadMore,
    super.key,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) =>
      NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.extentAfter == 0) onLoadMore();
          return false;
        },
        child: ListView.builder(itemCount: itemCount, itemBuilder: itemBuilder),
      );
}
