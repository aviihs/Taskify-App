import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

/// Reusable pull-to-refresh wrapper widget for scrollable views.
class AppRefresh extends StatelessWidget {
  const AppRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
    this.color,
  });

  final Future<void> Function() onRefresh;
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? AppColors.primary,
      backgroundColor: Theme.of(context).cardColor,
      child: child,
    );
  }
}