import 'package:flutter/material.dart';
import 'package:taskify_app/core/design_system/theme/app_palette.dart';

/// Reusable radio tile group selection option.
class AppRadio<T> extends StatelessWidget {
  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.activeColor,
    this.margin,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final String title;
  final String? subtitle;
  final Color? activeColor;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      // ignore: deprecated_member_use
      child: RadioListTile<T>(
        value: value,
        // ignore: deprecated_member_use
        groupValue: groupValue,
        // ignore: deprecated_member_use
        onChanged: onChanged,
        activeColor: activeColor ?? context.colors.primary,
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: context.typography.bodyLarge.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle != null
            ? Text(subtitle!, style: context.typography.bodyMedium)
            : null,
      ),
    );
  }
}
