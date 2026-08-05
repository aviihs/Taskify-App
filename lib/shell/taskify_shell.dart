import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify_app/core/constants/app_colors.dart';
import 'package:taskify_app/core/widget/navigation/app_bottom_nav.dart';
import 'package:taskify_app/router/routes/app_routes.dart';
import 'package:taskify_app/shell/shell_bottom_nav.dart';
import 'package:taskify_app/shell/shell_center_fab.dart';

class TaskifyShell extends StatelessWidget {
  const TaskifyShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    void onTap(int index) {
      HapticFeedback.selectionClick();
      navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      resizeToAvoidBottomInset: false,
      body: navigationShell,
      bottomNavigationBar: ShellBottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: onTap,
        items: const [
          AppNavItem(
            icon: Icons.dashboard_outlined,
            activeIcon: Icons.dashboard_rounded,
            label: 'First',
          ),
          AppNavItem(
            icon: Icons.view_agenda_outlined,
            activeIcon: Icons.view_agenda_rounded,
            label: 'Second',
          ),
          AppNavItem(
            icon: Icons.calendar_month_outlined,
            activeIcon: Icons.calendar_month_rounded,
            label: 'Third',
          ),
          AppNavItem(
            icon: Icons.person_outline_rounded,
            activeIcon: Icons.person_rounded,
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: ShellCenterFab(
        icon: Icons.add_rounded,
        tooltip: 'Add',
        onPressed: () => context.push(AppRoutes.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
