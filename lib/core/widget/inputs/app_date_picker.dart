import 'package:flutter/material.dart';

import 'app_textfield.dart';

/// Reusable date selector field opening date picker dialog.
class AppDatePicker extends StatelessWidget {
  const AppDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.label = 'Select Date',
    this.hintText = 'YYYY-MM-DD',
    this.firstDate,
    this.lastDate,
    this.margin,
  });

  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final String label;
  final String hintText;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final EdgeInsetsGeometry? margin;

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    );

    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = selectedDate != null
        ? '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}'
        : '';

    return GestureDetector(
      onTap: () => _pickDate(context),
      child: AbsorbPointer(
        child: AppTextField(
          label: label,
          hintText: hintText,
          controller: TextEditingController(text: dateStr),
          prefixIcon: const Icon(Icons.calendar_today_rounded),
          suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
          margin: margin,
        ),
      ),
    );
  }
}
