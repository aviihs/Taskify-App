import 'package:flutter/material.dart';
import 'package:taskify_app/core/theme/app_theme.dart';
import 'package:taskify_app/router/app_router.dart';
import 'package:taskify_app/router/routes/app_routes.dart';

void main() {
  runApp(const TaskifyApp());
}

class TaskifyApp extends StatelessWidget {
  const TaskifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskify',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoutes.login,
    );
  }
}
