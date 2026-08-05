import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_ui.dart';
import 'app_button.dart';

/// Reusable async action button that automatically handles loading state during execution.
class AppLoadingButton extends StatefulWidget {
  const AppLoadingButton({
    super.key,
    required this.text,
    required this.onFuturePressed,
    this.icon,
    this.backgroundColor,
    this.height = AppUi.buttonHeight,
    this.useGradient = false,
  });

  final String text;
  final Future<void> Function()? onFuturePressed;
  final IconData? icon;
  final Color? backgroundColor;
  final double height;
  final bool useGradient;

  @override
  State<AppLoadingButton> createState() => _AppLoadingButtonState();
}

class _AppLoadingButtonState extends State<AppLoadingButton> {
  bool _isLoading = false;

  Future<void> _handlePress() async {
    if (_isLoading || widget.onFuturePressed == null) return;
    setState(() => _isLoading = true);
    try {
      await widget.onFuturePressed!();
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: widget.text,
      onPressed: widget.onFuturePressed != null ? _handlePress : null,
      isLoading: _isLoading,
      icon: widget.icon,
      backgroundColor: widget.backgroundColor ?? AppColors.primary,
      height: widget.height,
      useGradient: widget.useGradient,
    );
  }
}
