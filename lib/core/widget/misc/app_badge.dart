import 'package:flutter/material.dart';

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
        bg = AppColors.primary.withValues(alpha: 0.15);
        fg = AppColors.primary;
        break;
      case AppBadgeVariant.success:
        bg = AppColors.successLight;
        fg = AppColors.success;
        break;
      case AppBadgeVariant.warning:
        bg = AppColors.warningLight;
        fg = AppColors.warning;
        break;
      case AppBadgeVariant.danger:
        bg = AppColors.errorLight;
        fg = AppColors.error;
        break;
      case AppBadgeVariant.info:
        bg = AppColors.infoLight;
        fg = AppColors.info;
        break;
      case AppBadgeVariant.neutral:
        bg = AppColors.surfaceVariant;
        fg = AppColors.textSecondary;
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
