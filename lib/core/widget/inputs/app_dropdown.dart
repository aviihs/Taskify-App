import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_typography.dart';
import '../../constants/app_ui.dart';

/// Reusable dropdown input field widget.
class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.label,
    this.hintText = 'Select option',
    this.errorText,
    this.prefixIcon,
    this.itemToString,
    this.margin,
  });

  final List<T> items;
  final ValueChanged<T?> onChanged;
  final T? value;
  final String? label;
  final String hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final String Function(T item)? itemToString;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null) ...[
            Text(
              label!,
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
          ],
          DropdownButtonFormField<T>(
            initialValue: value,
            items: items.map((T item) {
              final displayText = itemToString != null
                  ? itemToString!(item)
                  : item.toString();
              return DropdownMenuItem<T>(
                value: item,
                child: Text(displayText, style: AppTypography.bodyLarge),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              prefixIcon: prefixIcon,
              filled: true,
              fillColor: AppColors.background,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppUi.borderRadius),
                borderSide: const BorderSide(color: AppColors.border),
              ),
            ),
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            dropdownColor: Theme.of(context).cardColor,
          ),
        ],
      ),
    );
  }
}