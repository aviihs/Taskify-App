import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../constants/app_ui.dart';
import '../design_system/theme/app_palette.dart';
import '../design_system/theme/brand_theme.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = _build(
    brightness: Brightness.light,
    palette: AppPalette.light,
    brand: BrandTheme.light,
  );

  static final ThemeData darkTheme = _build(
    brightness: Brightness.dark,
    palette: AppPalette.dark,
    brand: BrandTheme.dark,
  );

  static ThemeData _build({
    required Brightness brightness,
    required AppPalette palette,
    required BrandTheme brand,
  }) {
    final isDark = brightness == Brightness.dark;
    final c = palette;

    OutlineInputBorder inputBorder(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppUi.borderRadius),
          borderSide: BorderSide(color: color, width: width),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
        primary: isDark ? c.primary : AppColors.primary,
        onPrimary: isDark ? const Color(0xFF1A1D2E) : Colors.white,
        secondary: isDark ? AppColors.secondaryLight : AppColors.secondary,
        surface: c.surface,
        onSurface: c.textPrimary,
        onSurfaceVariant: c.textSecondary,
        outline: c.border,
        outlineVariant: c.divider,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: c.scaffoldBackground,
      canvasColor: c.surface,
      dividerColor: c.divider,
      dividerTheme: DividerThemeData(color: c.divider, thickness: 1),
      extensions: [brand, palette],
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? c.surface : AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.heading2.copyWith(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      textTheme: TextTheme(
        headlineLarge: AppTypography.heading1.copyWith(color: c.textPrimary),
        headlineMedium: AppTypography.heading2.copyWith(color: c.textPrimary),
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: c.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: c.textPrimary,
        ),
        bodyLarge: AppTypography.bodyLarge.copyWith(color: c.textSecondary),
        bodyMedium: AppTypography.bodyMedium.copyWith(color: c.textSecondary),
        bodySmall: TextStyle(fontSize: 12, color: c.textMuted),
        labelLarge: AppTypography.buttonText,
        labelMedium: AppTypography.labelMedium.copyWith(color: c.textPrimary),
      ),
      iconTheme: IconThemeData(color: c.textSecondary),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: c.disabled,
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
          foregroundColor: c.textPrimary,
          minimumSize: const Size(double.infinity, AppUi.buttonHeight),
          padding: AppSpacing.smallButtonPadding,
          side: BorderSide(color: c.border, width: 1.2),
          textStyle: AppTypography.buttonText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppUi.borderRadius),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: c.primary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: inputBorder(c.border),
        enabledBorder: inputBorder(c.border),
        focusedBorder: inputBorder(c.primary, 1.5),
        errorBorder: inputBorder(AppColors.error, 1.5),
        focusedErrorBorder: inputBorder(AppColors.error, 1.5),
        hintStyle: AppTypography.bodyMedium.copyWith(color: c.textMuted),
        labelStyle: AppTypography.bodyMedium.copyWith(color: c.textSecondary),
        prefixIconColor: c.textMuted,
        suffixIconColor: c.textMuted,
      ),
      cardTheme: CardThemeData(
        color: c.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppUi.cardRadius),
          side: BorderSide(color: c.divider, width: 1),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppUi.cardRadius),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: c.textSecondary,
        textColor: c.textPrimary,
        selectedColor: c.primary,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.primary : c.textMuted,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? c.primary.withValues(alpha: 0.35)
              : c.surfaceVariant,
        ),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: c.primary),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
