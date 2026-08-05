import 'package:flutter/material.dart';
import 'package:taskify_app/features/shell/presentation/pages/shell_profile_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShellProfilePage(
      title: 'Profile',
      subtitle: 'Normal user workspace',
      icon: Icons.person_rounded,
      showAdminPanelButton: true,
    );
  }
}
