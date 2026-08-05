import 'package:flutter/material.dart';
import 'package:taskify_app/features/shell/presentation/pages/shell_placeholder_page.dart';

class AdminTasksPage extends StatelessWidget {
  const AdminTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShellPlaceholderPage(
      title: 'Tasks',
      subtitle: 'Review task activity across the workspace.',
      icon: Icons.assignment_rounded,
    );
  }
}
