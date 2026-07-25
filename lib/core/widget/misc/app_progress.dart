import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_typography.dart';

/// Reusable linear progress indicator with optional label and percentage.
class AppProgress extends StatelessWidget {
  const AppProgress({
    super.key,
    required this.progress,
    this.label,
    this.showPercentage = true,
    this.height = 8,
    this.color,
    this.backgroundColor,
    this.margin,
  });

  /// Progress value between 0.0 and 1.0.
  final double progress;
  final String? label;
  final bool showPercentage;
  final double height;
  final Color? color;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final clampedValue = progress.clamp(0.0, 1.0);
    final percentText = '${(clampedValue * 100).toInt()}%';

    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null || showPercentage) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (label != null)
                  Text(
                    label!,
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                if (showPercentage)
                  Text(
                    percentText,
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
          ],
          ClipRRect(
            borderRadius: BorderRadius.circular(height / 2),
            child: LinearProgressIndicator(
              value: clampedValue,
              minHeight: height,
              color: color ?? AppColors.primary,
              backgroundColor: backgroundColor ?? AppColors.surfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}