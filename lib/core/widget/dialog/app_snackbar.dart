import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_ui.dart';

enum AppSnackBarType { success, error, info, warning }

/// Helper class for showing styled floating SnackBars/Toasts across the app.
class AppSnackBar {
  AppSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    AppSnackBarType type = AppSnackBarType.info,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    Color bg;
    IconData icon;

    switch (type) {
      case AppSnackBarType.success:
        bg = AppColors.success;
        icon = Icons.check_circle_outline_rounded;
        break;
      case AppSnackBarType.error:
        bg = AppColors.error;
        icon = Icons.error_outline_rounded;
        break;
      case AppSnackBarType.warning:
        bg = AppColors.warning;
        icon = Icons.warning_amber_rounded;
        break;
      case AppSnackBarType.info:
        bg = AppColors.primary;
        icon = Icons.info_outline_rounded;
        break;
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: AppUi.iconSM),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: bg,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppUi.borderRadius),
        ),
        action: action,
      ),
    );
  }

  static void success(BuildContext context, String message) =>
      show(context, message: message, type: AppSnackBarType.success);

  static void error(BuildContext context, String message) =>
      show(context, message: message, type: AppSnackBarType.error);

  static void info(BuildContext context, String message) =>
      show(context, message: message, type: AppSnackBarType.info);

  static void warning(BuildContext context, String message) =>
      show(context, message: message, type: AppSnackBarType.warning);
}
