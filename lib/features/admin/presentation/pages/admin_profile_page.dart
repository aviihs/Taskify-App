import 'package:flutter/material.dart';
import 'package:taskify_app/features/shell/presentation/pages/shell_profile_page.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShellProfilePage(
      title: 'Admin Profile',
      subtitle: 'Admin workspace',
      icon: Icons.admin_panel_settings_rounded,
    );
  }
}
