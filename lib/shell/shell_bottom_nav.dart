import 'package:flutter/material.dart';
import 'package:taskify_app/core/constants/app_colors.dart';
import 'package:taskify_app/core/constants/app_ui.dart';
import 'package:taskify_app/core/widget/navigation/app_bottom_nav.dart';

class ShellBottomNav extends StatelessWidget {
  const ShellBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.hasCenterGap = true,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppNavItem> items;
  final bool hasCenterGap;

  @override
  Widget build(BuildContext context) {
    if (!hasCenterGap) {
      return AppBottomNav(
        currentIndex: currentIndex,
        onTap: onTap,
        items: items,
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1E2235) : Colors.white;
    final inactiveColor = isDark
        ? const Color(0xFF6B7280)
        : AppColors.textMuted;
    final center = items.length ~/ 2;

    return BottomAppBar(
      height: AppUi.bottomNavHeight,
      color: backgroundColor,
      elevation: 14,
      shadowColor: Colors.black.withValues(alpha: 0.16),
      surfaceTintColor: Colors.transparent,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      padding: EdgeInsets.zero,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            for (var index = 0; index < items.length; index++) ...[
              Expanded(
                child: _ShellNavTab(
                  item: items[index],
                  isSelected: index == currentIndex,
                  inactiveColor: inactiveColor,
                  onTap: () => onTap(index),
                ),
              ),
              if (index == center - 1) const SizedBox(width: 82),
            ],
          ],
        ),
      ),
    );
  }
}

class _ShellNavTab extends StatelessWidget {
  const _ShellNavTab({
    required this.item,
    required this.isSelected,
    required this.inactiveColor,
    required this.onTap,
  });

  final AppNavItem item;
  final bool isSelected;
  final Color inactiveColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : inactiveColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
      child: Material(
        color: isSelected
            ? AppColors.primary.withValues(alpha: 0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          hoverColor: AppColors.primary.withValues(alpha: 0.06),
          splashColor: AppColors.primary.withValues(alpha: 0.12),
          highlightColor: AppColors.primary.withValues(alpha: 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? (item.activeIcon ?? item.icon) : item.icon,
                color: color,
                size: AppUi.iconMD,
              ),
              const SizedBox(height: 4),
              Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
