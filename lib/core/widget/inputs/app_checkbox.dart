import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_typography.dart';

/// Reusable checkbox input tile with title, subtitle, and custom styling.
class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.activeColor,
    this.margin,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;
  final String title;
  final String? subtitle;
  final Color? activeColor;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor ?? AppColors.primary,
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
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
