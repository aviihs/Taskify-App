import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_typography.dart';
import '../../constants/app_ui.dart';

/// Reusable outlined button with icon support, loading state, and custom border colors.
class AppOutlineButton extends StatelessWidget {
  const AppOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.borderColor,
    this.textColor,
    this.height = AppUi.buttonHeight,
    this.width,
    this.borderRadius,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final Color? borderColor;
  final Color? textColor;
  final double height;
  final double? width;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? AppUi.borderRadius;
    final effectiveColor = textColor ?? AppColors.textPrimary;
    final isClickable = !isLoading && !isDisabled && onPressed != null;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: isClickable ? onPressed : null,
        style: OutlinedButton.styleFrom(
          foregroundColor: effectiveColor,
          side: BorderSide(
            color: isDisabled
                ? AppColors.disabled
                : (borderColor ?? AppColors.surfaceVariant),
            width: 1.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveRadius),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) ...[
              SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
            ] else if (icon != null) ...[
              Icon(icon, size: AppUi.iconSM, color: effectiveColor),
              const SizedBox(width: AppSpacing.sm),
            ],
            Text(
              text,
              style: AppTypography.buttonText.copyWith(color: effectiveColor),
            ),
          ],
        ),
      ),
    );
  }
}
