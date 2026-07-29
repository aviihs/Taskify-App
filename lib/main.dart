import 'package:flutter/material.dart';

import 'core/design_system/design_system.dart';
import 'router/app_router.dart';
import 'router/routes/app_routes.dart';

void main() {
  runApp(const TaskifyApp());
}

class TaskifyApp extends StatelessWidget {
  const TaskifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, child) {
        return MaterialApp.router(
          title: 'Taskify',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          routerConfig: appRouter,
        );
      },
    );
  }
}
