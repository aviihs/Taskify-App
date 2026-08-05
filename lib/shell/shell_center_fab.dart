import 'package:flutter/material.dart';
import 'package:taskify_app/core/widget/buttons/app_fab.dart';

class ShellCenterFab extends StatelessWidget {
  const ShellCenterFab({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: AppFab(
        heroTag: 'taskify-shell-add-fab',
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
