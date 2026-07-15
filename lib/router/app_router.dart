import 'package:flutter/material.dart';
import 'package:taskify_app/core/auth/authentication/presentation/screens/login_screen.dart';
import 'package:taskify_app/core/auth/authentication/presentation/screens/register_screen.dart';
import 'package:taskify_app/features/home/presentation/pages/home_page.dart';

import 'routes/app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
