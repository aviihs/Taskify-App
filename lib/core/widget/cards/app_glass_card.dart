import 'dart:ui';
import 'package:flutter/material.dart';

import '../../constants/app_spacing.dart';
import '../../constants/app_ui.dart';

/// Reusable glassmorphic frosted-glass container with blur effect.
class AppGlassCard extends StatelessWidget {
  const AppGlassCard({
    super.key,
    required this.child,
    this.padding = AppSpacing.cardPadding,
    this.margin,
    this.onTap,
    this.blur = AppUi.glassBlur,
    this.opacity = AppUi.glassOpacity,
    this.borderColor,
    this.borderRadius,
    this.width,
    this.height,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double blur;
  final double opacity;
  final Color? borderColor;
  final double? borderRadius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? AppUi.cardRadius;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final border = borderColor ??
        (isDark ? const Color(0x33FFFFFF) : const Color(0x66FFFFFF));
    final overlayColor = isDark ? Colors.black : Colors.white;

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(effectiveRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            decoration: BoxDecoration(
              color: overlayColor.withValues(alpha: opacity),
              borderRadius: BorderRadius.circular(effectiveRadius),
              border: Border.all(color: border, width: 1.2),
            ),
            child: Material(
              color: Colors.transparent,
              child: onTap != null
                  ? InkWell(
                      onTap: onTap,
                      borderRadius: BorderRadius.circular(effectiveRadius),
                      child: Padding(padding: padding, child: child),
                    )
                  : Padding(padding: padding, child: child),
            ),
          ),
        ),
      ),
    );
  }
}