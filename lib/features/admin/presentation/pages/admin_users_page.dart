import 'package:flutter/material.dart';
import 'package:taskify_app/features/shell/presentation/pages/shell_placeholder_page.dart';

class AdminUsersPage extends StatelessWidget {
  const AdminUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShellPlaceholderPage(
      title: 'Users',
      subtitle: 'Manage team members and user access.',
      icon: Icons.group_rounded,
    );
  }
}
