import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_typography.dart';
import '../../constants/app_ui.dart';
import '../image/app_avatar.dart';

class AppDrawerItem {
  const AppDrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.badgeText,
    this.isSelected = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final String? badgeText;
  final bool isSelected;
}

/// Reusable modern side navigation drawer widget with user header.
class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.userName,
    this.userEmail,
    this.avatarUrl,
    required this.items,
    this.onLogout,
    this.headerBackground,
  });

  final String userName;
  final String? userEmail;
  final String? avatarUrl;
  final List<AppDrawerItem> items;
  final VoidCallback? onLogout;
  final Gradient? headerBackground;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 24),
            decoration: BoxDecoration(
              gradient: headerBackground ?? AppGradients.drawer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppAvatar(
                  imageUrl: avatarUrl,
                  name: userName,
                  size: AppUi.avatarLG,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  userName,
                  style: AppTypography.heading2.copyWith(color: Colors.white),
                ),
                if (userEmail != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    userEmail!,
                    style: AppTypography.bodyMedium.copyWith(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              itemCount: items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 4),
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: Icon(
                    item.icon,
                    color: item.isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                  title: Text(
                    item.title,
                    style: AppTypography.bodyLarge.copyWith(
                      color: item.isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      fontWeight:
                          item.isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  trailing: item.badgeText != null
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            item.badgeText!,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : null,
                  selected: item.isSelected,
                  onTap: item.onTap,
                );
              },
            ),
          ),
          if (onLogout != null) ...[
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: AppColors.error),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: onLogout,
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}