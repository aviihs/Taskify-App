import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_ui.dart';
import 'app_network_image.dart';

/// Reusable user avatar with image/initials fallback and optional online status indicator.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = AppUi.avatarMD,
    this.isOnline,
    this.onTap,
    this.backgroundColor,
  });

  final String? imageUrl;
  final String? name;
  final double size;
  final bool? isOnline;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  String get _initials {
    if (name == null || name!.trim().isEmpty) return '?';
    final parts = name!.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.primary;

    Widget avatar = imageUrl != null && imageUrl!.isNotEmpty
        ? AppNetworkImage(
            imageUrl: imageUrl,
            width: size,
            height: size,
            borderRadius: size / 2,
          )
        : Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: bg,
              shape: BoxShape.circle,
              gradient: AppGradients.avatar,
            ),
            child: Center(
              child: Text(
                _initials,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size * 0.4,
                ),
              ),
            ),
          );

    if (isOnline != null) {
      avatar = Stack(
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size * 0.28,
              height: size * 0.28,
              decoration: BoxDecoration(
                color: isOnline! ? AppColors.success : AppColors.disabledText,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        ],
      );
    }

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: avatar);
    }

    return avatar;
  }
}