import 'package:flutter/material.dart';
import 'package:taskify_app/shell/pages/shell_placeholder_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShellPlaceholderPage(
      title: 'Profile',
      subtitle: 'Profile tab content goes here.',
      icon: Icons.person_rounded,
    );
  }
}
