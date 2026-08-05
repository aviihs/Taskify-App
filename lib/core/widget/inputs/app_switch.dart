import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_typography.dart';

/// Reusable modern toggle switch tile widget.
class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.activeColor,
    this.margin,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String title;
  final String? subtitle;
  final Color? activeColor;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeTrackColor: (activeColor ?? AppColors.primary).withValues(
          alpha: 0.5,
        ),
        // ignore: deprecated_member_use
        activeColor: activeColor ?? AppColors.primary,
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w500),
        ),
        subtitle: subtitle != null
            ? Text(subtitle!, style: AppTypography.bodyMedium)
            : null,
      ),
    );
  }
}
