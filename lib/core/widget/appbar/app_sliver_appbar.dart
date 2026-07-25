import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_typography.dart';

/// Reusable Sliver AppBar for collapsible headers and scroll views.
class AppSliverAppBar extends StatelessWidget {
  const AppSliverAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.expandedHeight = 200,
    this.flexibleSpaceBackground,
    this.pinned = true,
    this.floating = false,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final double expandedHeight;
  final Widget? flexibleSpaceBackground;
  final bool pinned;
  final bool floating;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: pinned,
      floating: floating,
      expandedHeight: expandedHeight,
      leading: leading,
      actions: actions,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          title,
          style: AppTypography.heading2.copyWith(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        background: flexibleSpaceBackground ??
            Container(
              decoration: const BoxDecoration(
                gradient: AppGradients.hero,
              ),
            ),
      ),
    );
  }
}