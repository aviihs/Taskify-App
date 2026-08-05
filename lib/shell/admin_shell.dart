import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify_app/core/auth/authentication/presentation/providers/auth_provider.dart';
import 'package:taskify_app/core/constants/app_colors.dart';
import 'package:taskify_app/core/widget/navigation/app_bottom_nav.dart';
import 'package:taskify_app/router/routes/app_routes.dart';
import 'package:taskify_app/shell/shell_bottom_nav.dart';
import 'package:taskify_app/shell/shell_center_fab.dart';

class AdminShell extends ConsumerWidget {
  const AdminShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final user = auth.user;

    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go(AppRoutes.login);
      });
      return const Scaffold(body: SizedBox.shrink());
    }

    if (!user.isAdmin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go(AppRoutes.home);
      });
      return const Scaffold(body: SizedBox.shrink());
    }

    void onTap(int index) {
      HapticFeedback.selectionClick();
      navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: navigationShell,
      bottomNavigationBar: ShellBottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: onTap,
        items: const [
          AppNavItem(
            icon: Icons.space_dashboard_outlined,
            activeIcon: Icons.space_dashboard_rounded,
            label: 'Dashboard',
          ),
          AppNavItem(
            icon: Icons.group_outlined,
            activeIcon: Icons.group_rounded,
            label: 'Users',
          ),
          AppNavItem(
            icon: Icons.assignment_outlined,
            activeIcon: Icons.assignment_rounded,
            label: 'Tasks',
          ),
          AppNavItem(
            icon: Icons.admin_panel_settings_outlined,
            activeIcon: Icons.admin_panel_settings_rounded,
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: ShellCenterFab(
        heroTag: 'admin-shell-user-app-fab',
        icon: Icons.apps_rounded,
        tooltip: 'Open user app',
        onPressed: () => context.go(AppRoutes.home),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
