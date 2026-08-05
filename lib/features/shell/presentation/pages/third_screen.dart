import 'package:flutter/material.dart';
import 'package:taskify_app/features/shell/presentation/pages/shell_placeholder_page.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShellPlaceholderPage(
      title: 'Third Screen',
      subtitle: 'Third tab content goes here.',
      icon: Icons.calendar_month_rounded,
    );
  }
}
