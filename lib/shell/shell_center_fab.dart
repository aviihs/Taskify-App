import 'package:flutter/material.dart';
import 'package:taskify_app/core/constants/app_colors.dart';
import 'package:taskify_app/core/constants/app_ui.dart';

class ShellCenterFab extends StatelessWidget {
  const ShellCenterFab({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.heroTag = 'taskify-shell-center-fab',
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final Object heroTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: AppShadows.primaryGlow(AppColors.primary),
      ),
      child: FloatingActionButton(
        heroTag: heroTag,
        onPressed: onPressed,
        tooltip: tooltip,
        elevation: 0,
        highlightElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textWhite,
        shape: CircleBorder(
          side: BorderSide(
            color: Theme.of(context).scaffoldBackgroundColor,
            width: 4,
          ),
        ),
        child: Ink(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppGradients.button,
          ),
          child: Center(
            child: Icon(icon, size: AppUi.iconLG, color: AppColors.textWhite),
          ),
        ),
      ),
    );
  }
}
