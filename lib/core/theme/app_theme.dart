import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../constants/app_ui.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    scaffoldBackgroundColor: AppColors.background,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.surface,
      elevation: 0,
      titleTextStyle: AppTypography.heading2,
    ),
    textTheme: const TextTheme(
      headlineLarge: AppTypography.heading1,
      headlineMedium: AppTypography.heading2,
      bodyLarge: AppTypography.bodyLarge,
      bodyMedium: AppTypography.bodyMedium,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        padding: AppSpacing.buttonPadding,
        textStyle: AppTypography.buttonText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppUi.borderRadius),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        padding: AppSpacing.smallButtonPadding,
        side: const BorderSide(color: AppColors.surfaceVariant),
        textStyle: AppTypography.buttonText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppUi.borderRadius),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.background,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: AppUi.inputBorder,
      enabledBorder: AppUi.inputBorder,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppUi.borderRadius)),
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      ),
      hintStyle: AppTypography.bodyMedium,
    ),
  );
}
