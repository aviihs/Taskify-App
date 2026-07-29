import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_ui.dart';

/// Reusable icon button supporting container background, badge indicators, and tooltips.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 42,
    this.iconSize = AppUi.iconMD,
    this.color,
    this.backgroundColor,
    this.borderColor,
    this.badgeCount,
    this.tooltip,
    this.borderRadius,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;
  final Color? color;
  final Color? backgroundColor;
  final Color? borderColor;
  final int? badgeCount;
  final String? tooltip;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? (size / 2);

    Widget button = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surfaceVariant.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(effectiveRadius),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 1.2)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(effectiveRadius),
          child: Center(
            child: Icon(
              icon,
              size: iconSize,
              color: color ?? AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );

    if (badgeCount != null && badgeCount! > 0) {
      button = Stack(
        clipBehavior: Clip.none,
        children: [
          button,
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Center(
                child: Text(
                  badgeCount! > 99 ? '99+' : badgeCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}