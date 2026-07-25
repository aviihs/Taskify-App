import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

/// Reusable circular activity loader and full-screen loading overlay.
class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    this.color,
    this.size = 32,
    this.strokeWidth = 3,
  });

  final Color? color;
  final double size;
  final double strokeWidth;

  static void showOverlay(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black38,
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: const AppLoader(),
        ),
      ),
    );
  }

  static void hideOverlay(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? AppColors.primary,
          ),
        ),
      ),
    );
  }
}