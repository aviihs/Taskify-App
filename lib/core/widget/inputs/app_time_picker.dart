import 'package:flutter/material.dart';

import 'app_textfield.dart';

/// Reusable time selector field opening time picker dialog.
class AppTimePicker extends StatelessWidget {
  const AppTimePicker({
    super.key,
    required this.selectedTime,
    required this.onTimeSelected,
    this.label = 'Select Time',
    this.hintText = 'HH:MM AM/PM',
    this.margin,
  });

  final TimeOfDay? selectedTime;
  final ValueChanged<TimeOfDay> onTimeSelected;
  final String label;
  final String hintText;
  final EdgeInsetsGeometry? margin;

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeStr = selectedTime != null ? selectedTime!.format(context) : '';

    return GestureDetector(
      onTap: () => _pickTime(context),
      child: AbsorbPointer(
        child: AppTextField(
          label: label,
          hintText: hintText,
          controller: TextEditingController(text: timeStr),
          prefixIcon: const Icon(Icons.access_time_rounded),
          suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
          margin: margin,
        ),
      ),
    );
  }
}
