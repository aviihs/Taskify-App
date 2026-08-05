import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_typography.dart';
import '../../constants/app_ui.dart';

enum AppInfoCardType { info, success, warning, error }

/// Reusable status/alert notification card widget.
class AppInfoCard extends StatelessWidget {
  const AppInfoCard({
    super.key,
    required this.title,
    this.message,
    this.type = AppInfoCardType.info,
    this.icon,
    this.onClose,
    this.actionText,
    this.onActionPressed,
    this.margin,
  });

  final String title;
  final String? message;
  final AppInfoCardType type;
  final IconData? icon;
  final VoidCallback? onClose;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color border;
    Color iconColor;
    IconData defaultIcon;

    switch (type) {
      case AppInfoCardType.info:
        bg = AppColors.infoLight;
        border = AppColors.info;
        iconColor = AppColors.info;
        defaultIcon = Icons.info_outline_rounded;
        break;
      case AppInfoCardType.success:
        bg = AppColors.successLight;
        border = AppColors.success;
        iconColor = AppColors.success;
        defaultIcon = Icons.check_circle_outline_rounded;
        break;
      case AppInfoCardType.warning:
        bg = AppColors.warningLight;
        border = AppColors.warning;
        iconColor = AppColors.warning;
        defaultIcon = Icons.warning_amber_rounded;
        break;
      case AppInfoCardType.error:
        bg = AppColors.errorLight;
        border = AppColors.error;
        iconColor = AppColors.error;
        defaultIcon = Icons.error_outline_rounded;
        break;
    }

    return Container(
      margin: margin,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppUi.borderRadius),
        border: Border.all(color: border.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon ?? defaultIcon, color: iconColor, size: AppUi.iconMD),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTypography.heading2.copyWith(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (message != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    message!,
                    style: AppTypography.bodyMedium.copyWith(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                if (actionText != null && onActionPressed != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  GestureDetector(
                    onTap: onActionPressed,
                    child: Text(
                      actionText!,
                      style: AppTypography.labelMedium.copyWith(
                        color: iconColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onClose != null) ...[
            const SizedBox(width: AppSpacing.xs),
            GestureDetector(
              onTap: onClose,
              child: const Icon(
                Icons.close_rounded,
                size: 18,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
