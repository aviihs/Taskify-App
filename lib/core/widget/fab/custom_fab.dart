import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_ui.dart';
import '../../constants/icons.dart';
import '../../constants/radius.dart';

/// Primary-styled pill floating action button used across list screens.
class CustomFAB extends StatelessWidget {
  const CustomFAB({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.backgroundColor,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  /// Defaults to brand primary color.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final color = backgroundColor ?? AppColors.primary;
    return Material(
      color: color,
      elevation: 0,
      borderRadius: AppRadius.controlBr,
      shadowColor: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: AppRadius.controlBr,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: AppRadius.controlBr,
            boxShadow: AppShadows.primaryGlow(color),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: AppIconSize.sm),
              const SizedBox(width: AppSpacing.sm),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
