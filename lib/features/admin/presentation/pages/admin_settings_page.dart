import 'package:flutter/material.dart';
import 'package:taskify_app/features/shell/presentation/pages/shell_placeholder_page.dart';

class AdminSettingsPage extends StatelessWidget {
  const AdminSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShellPlaceholderPage(
      title: 'Settings',
      subtitle: 'Configure workspace and admin preferences.',
      icon: Icons.tune_rounded,
    );
  }
}
