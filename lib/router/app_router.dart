import 'package:go_router/go_router.dart';
import 'package:taskify_app/core/auth/authentication/presentation/screens/forgot_password_screen.dart';
import 'package:taskify_app/core/auth/authentication/presentation/screens/full_details_screen.dart';
import 'package:taskify_app/core/auth/authentication/presentation/screens/otp_screen.dart';
import 'package:taskify_app/core/auth/authentication/presentation/screens/verify_otp_screen.dart';
import 'package:taskify_app/features/admin/presentation/pages/admin_dashboard_page.dart';
import 'package:taskify_app/features/admin/presentation/pages/admin_settings_page.dart';
import 'package:taskify_app/features/admin/presentation/pages/admin_tasks_page.dart';
import 'package:taskify_app/features/admin/presentation/pages/admin_users_page.dart';

import 'routes/app_routes.dart';
import 'package:taskify_app/core/auth/authentication/presentation/screens/login_screen.dart';
import 'package:taskify_app/core/auth/authentication/presentation/screens/register_screen.dart';
import 'package:taskify_app/features/shell/presentation/pages/add_page.dart';
import 'package:taskify_app/features/shell/presentation/pages/first_screen.dart';
import 'package:taskify_app/features/shell/presentation/pages/profile_screen.dart';
import 'package:taskify_app/features/shell/presentation/pages/second_screen.dart';
import 'package:taskify_app/features/shell/presentation/pages/third_screen.dart';
import 'package:taskify_app/shell/admin_shell.dart';
import 'package:taskify_app/shell/taskify_shell.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AdminShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.adminDashboard,
              builder: (context, state) => const AdminDashboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.adminUsers,
              builder: (context, state) => const AdminUsersPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.adminTasks,
              builder: (context, state) => const AdminTasksPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.adminSettings,
              builder: (context, state) => const AdminSettingsPage(),
            ),
          ],
        ),
      ],
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return TaskifyShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const FirstScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.second,
              builder: (context, state) => const SecondScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.third,
              builder: (context, state) => const ThirdScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(path: AppRoutes.add, builder: (context, state) => const AddPage()),
    GoRoute(
      path: AppRoutes.otpScreen,
      builder: (context, state) {
        final email = state.extra as String?;
        return OtpScreen(email: email);
      },
    ),
    GoRoute(
      path: AppRoutes.fullDetails,
      builder: (_, _) => const FullDetailsScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.verifyOtp,
      builder: (context, state) {
        final email = state.extra as String?;
        return VerifyOtpScreen(email: email);
      },
    ),
  ],
);
