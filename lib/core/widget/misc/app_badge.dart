import 'package:flutter/material.dart';
import 'package:taskify_app/core/design_system/theme/app_palette.dart';

import '../../constants/app_colors.dart';

enum AppBadgeVariant { primary, success, warning, danger, info, neutral }

/// Reusable status badge, pill chip, or tag widget.
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.neutral,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  });

  final String label;
  final AppBadgeVariant variant;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (variant) {
      case AppBadgeVariant.primary:
        bg = context.colors.primary.withValues(alpha: 0.15);
        fg = context.colors.primary;
        break;
      case AppBadgeVariant.success:
        bg = context.colors.successLight;
        fg = AppColors.success;
        break;
      case AppBadgeVariant.warning:
        bg = context.colors.warningLight;
        fg = AppColors.warning;
        break;
      case AppBadgeVariant.danger:
        bg = context.colors.errorLight;
        fg = AppColors.error;
        break;
      case AppBadgeVariant.info:
        bg = context.colors.infoLight;
        fg = AppColors.info;
        break;
      case AppBadgeVariant.neutral:
        bg = context.colors.surfaceVariant;
        fg = context.colors.textSecondary;
        break;
    }

    final effectiveBg = backgroundColor ?? bg;
    final effectiveFg = textColor ?? fg;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: effectiveFg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: effectiveFg,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
