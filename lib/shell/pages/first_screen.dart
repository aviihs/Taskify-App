import 'package:flutter/material.dart';
import 'package:taskify_app/shell/pages/shell_placeholder_page.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShellPlaceholderPage(
      title: 'First Screen',
      subtitle: 'First tab content goes here.',
      icon: Icons.dashboard_rounded,
    );
  }
}
