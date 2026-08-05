import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../constants/app_ui.dart';
import '../design_system/theme/brand_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    extensions: [BrandTheme.light],
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.surface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTypography.heading2,
    ),
    textTheme: const TextTheme(
      headlineLarge: AppTypography.heading1,
      headlineMedium: AppTypography.heading2,
      bodyLarge: AppTypography.bodyLarge,
      bodyMedium: AppTypography.bodyMedium,
      labelLarge: AppTypography.buttonText,
      labelMedium: AppTypography.labelMedium,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        minimumSize: const Size(double.infinity, AppUi.buttonHeight),
        padding: AppSpacing.buttonPadding,
        textStyle: AppTypography.buttonText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppUi.borderRadius),
        ),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        minimumSize: const Size(double.infinity, AppUi.buttonHeight),
        padding: AppSpacing.smallButtonPadding,
        side: const BorderSide(color: AppColors.border, width: 1.2),
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
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppUi.borderRadius),
        borderSide: const BorderSide(color: AppColors.border, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppUi.borderRadius),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppUi.borderRadius),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
    ),
    cardTheme: CardThemeData(
      color: AppColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppUi.cardRadius),
        side: const BorderSide(color: AppColors.divider, width: 1),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppUi.cardRadius),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      surface: const Color(0xFF1E2235),
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: const Color(0xFF121522),
    extensions: [BrandTheme.dark],
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E2235),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTypography.heading2,
    ),
    textTheme: TextTheme(
      headlineLarge: AppTypography.heading1.copyWith(color: Colors.white),
      headlineMedium: AppTypography.heading2.copyWith(color: Colors.white),
      bodyLarge: AppTypography.bodyLarge.copyWith(
        color: const Color(0xFFD1D5DB),
      ),
      bodyMedium: AppTypography.bodyMedium.copyWith(
        color: const Color(0xFF9CA3AF),
      ),
      labelLarge: AppTypography.buttonText,
      labelMedium: AppTypography.labelMedium.copyWith(
        color: AppColors.primaryLight,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, AppUi.buttonHeight),
        padding: AppSpacing.buttonPadding,
        textStyle: AppTypography.buttonText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppUi.borderRadius),
        ),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, AppUi.buttonHeight),
        padding: AppSpacing.smallButtonPadding,
        side: const BorderSide(color: Color(0xFF374151), width: 1.2),
        textStyle: AppTypography.buttonText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppUi.borderRadius),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1A1D2E),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: AppUi.inputBorder,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppUi.borderRadius),
        borderSide: const BorderSide(color: Color(0xFF374151), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppUi.borderRadius),
        borderSide: const BorderSide(color: AppColors.primaryLight, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppUi.borderRadius),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      hintStyle: AppTypography.bodyMedium.copyWith(
        color: const Color(0xFF6B7280),
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E2235),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppUi.cardRadius),
        side: const BorderSide(color: Color(0xFF2A2E45), width: 1),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: const Color(0xFF1E2235),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppUi.cardRadius),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF1E2235),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
  );
}
