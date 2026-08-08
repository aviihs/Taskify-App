import 'package:flutter/material.dart';
import 'package:taskify_app/features/shell/presentation/pages/shell_placeholder_page.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShellPlaceholderPage(
      title: 'Admin Dashboard',
      subtitle: 'Overview, reports, and quick admin insights.',
      icon: Icons.space_dashboard_rounded,
    );
  }
}

