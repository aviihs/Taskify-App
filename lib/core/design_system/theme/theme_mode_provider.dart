import 'package:flutter/material.dart';

/// Provider / ValueNotifier for controlling the current app theme mode.
class ThemeModeNotifier extends ValueNotifier<ThemeMode> {
  ThemeModeNotifier([super.initialMode = ThemeMode.system]);

  void setThemeMode(ThemeMode mode) {
    value = mode;
  }

  void toggleTheme(BuildContext context) {
    final isDark = value == ThemeMode.dark ||
        (value == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);
    value = isDark ? ThemeMode.light : ThemeMode.dark;
  }

  bool isDarkMode(BuildContext context) {
    if (value == ThemeMode.dark) return true;
    if (value == ThemeMode.light) return false;
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }
}

/// Global instance for theme mode switching
final themeModeNotifier = ThemeModeNotifier();
