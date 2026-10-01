import 'package:flutter/material.dart';
import 'package:taskify_app/core/design_system/theme/app_palette.dart';

import '../../constants/app_spacing.dart';
import '../../constants/app_ui.dart';
import '../misc/dash_border.dart';

/// Reusable image upload/selector box with preview and remove action.
class AppImagePicker extends StatelessWidget {
  const AppImagePicker({
    super.key,
    required this.onTap,
    this.imageUrl,
    this.label = 'Upload Image',
    this.height = 140,
    this.onRemove,
    this.margin,
  });

  final VoidCallback onTap;
  final String? imageUrl;
  final String label;
  final double height;
  final VoidCallback? onRemove;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppUi.borderRadius),
                  child: Image.network(
                    imageUrl!,
                    width: double.infinity,
                    height: height,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onRemove ?? onTap,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : CustomDashBorder(
              borderRadius: AppUi.borderRadius,
              color: context.colors.border,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(AppUi.borderRadius),
                child: Container(
                  width: double.infinity,
                  height: height,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: context.colors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.cloud_upload_outlined,
                          color: context.colors.primary,
                          size: AppUi.iconMD,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        label,
                        style: context.typography.buttonText.copyWith(
                          color: context.colors.primary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'PNG, JPG up to 10MB',
                        style: context.typography.bodyMedium.copyWith(
                          fontSize: 11,
                          color: context.colors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
