import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_ui.dart';
import '../loading/app_shimmer.dart';

/// Reusable network image component with loading shimmer placeholder and fallback error widget.
class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.fallbackIcon = Icons.image_not_supported_rounded,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double? borderRadius;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? AppUi.borderRadius;

    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildPlaceholder(effectiveRadius);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(effectiveRadius),
      child: Image.network(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return AppShimmer(
            width: width ?? double.infinity,
            height: height ?? double.infinity,
            borderRadius: effectiveRadius,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder(effectiveRadius);
        },
      ),
    );
  }

  Widget _buildPlaceholder(double radius) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
        child: Icon(
          fallbackIcon,
          color: AppColors.textMuted,
          size: AppUi.iconMD,
        ),
      ),
    );
  }
}