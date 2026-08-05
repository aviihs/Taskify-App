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

    return Container(
      height: AppUi.bottomNavHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
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
            if (index == center - 1) const SizedBox(width: 72),
          ],
        ],
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

    return InkWell(
      onTap: onTap,
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
    );
  }
}
