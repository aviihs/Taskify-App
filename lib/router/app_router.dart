import 'package:go_router/go_router.dart';
import 'package:taskify_app/core/auth/authentication/presentation/screens/otp_screen.dart';

import 'routes/app_routes.dart';
import 'package:taskify_app/core/auth/authentication/presentation/screens/login_screen.dart';
import 'package:taskify_app/core/auth/authentication/presentation/screens/register_screen.dart';
import 'package:taskify_app/features/home/presentation/pages/home_page.dart';

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

    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
     GoRoute(
      path: AppRoutes.otpScreen,
      builder: (context, state) => const OtpScreen(),
    ),
  ],
);