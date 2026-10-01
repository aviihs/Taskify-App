import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_typography.dart';
import 'brand_theme.dart';

/// Brightness-aware colour tokens. Widgets read these through
/// `context.colors` so the same code renders correctly in light and dark
/// mode. Fixed brand/status colours that look the same in both modes stay
/// on [AppColors].
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.primary,
    required this.background,
    required this.scaffoldBackground,
    required this.surface,
    required this.surfaceVariant,
    required this.card,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.border,
    required this.divider,
    required this.disabled,
    required this.disabledText,
    required this.successLight,
    required this.warningLight,
    required this.errorLight,
    required this.infoLight,
    required this.shadow,
  });

  /// Brand colour for foreground use (icons, links, selected states).
  /// Filled brand backgrounds keep using [AppColors.primary].
  final Color primary;
  final Color background;
  final Color scaffoldBackground;
  final Color surface;
  final Color surfaceVariant;
  final Color card;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color border;
  final Color divider;
  final Color disabled;
  final Color disabledText;
  final Color successLight;
  final Color warningLight;
  final Color errorLight;
  final Color infoLight;
  final Color shadow;

  static const AppPalette light = AppPalette(
    primary: AppColors.primary,
    background: AppColors.background,
    scaffoldBackground: AppColors.scaffoldBackground,
    surface: AppColors.surface,
    surfaceVariant: AppColors.surfaceVariant,
    card: AppColors.card,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    textMuted: AppColors.textMuted,
    border: AppColors.border,
    divider: AppColors.divider,
    disabled: AppColors.disabled,
    disabledText: AppColors.disabledText,
    successLight: AppColors.successLight,
    warningLight: AppColors.warningLight,
    errorLight: AppColors.errorLight,
    infoLight: AppColors.infoLight,
    shadow: AppColors.shadow,
  );

  static const AppPalette dark = AppPalette(
    primary: Color(0xFFA5ABEA),
    background: Color(0xFF1A1D2E),
    scaffoldBackground: Color(0xFF121522),
    surface: Color(0xFF1E2235),
    surfaceVariant: Color(0xFF2A2E45),
    card: Color(0xFF1E2235),
    textPrimary: Color(0xFFE8EAF4),
    textSecondary: Color(0xFFA9AEC8),
    textMuted: Color(0xFF7A7F9A),
    border: Color(0xFF353A55),
    divider: Color(0xFF2A2E45),
    disabled: Color(0xFF3A3F5A),
    disabledText: Color(0xFF6B7085),
    successLight: Color(0x2622C55E),
    warningLight: Color(0x26F59E0B),
    errorLight: Color(0x26EF4444),
    infoLight: Color(0x263B82F6),
    shadow: Color(0x40000000),
  );

  @override
  AppPalette copyWith({
    Color? primary,
    Color? background,
    Color? scaffoldBackground,
    Color? surface,
    Color? surfaceVariant,
    Color? card,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? border,
    Color? divider,
    Color? disabled,
    Color? disabledText,
    Color? successLight,
    Color? warningLight,
    Color? errorLight,
    Color? infoLight,
    Color? shadow,
  }) {
    return AppPalette(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      card: card ?? this.card,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      disabled: disabled ?? this.disabled,
      disabledText: disabledText ?? this.disabledText,
      successLight: successLight ?? this.successLight,
      warningLight: warningLight ?? this.warningLight,
      errorLight: errorLight ?? this.errorLight,
      infoLight: infoLight ?? this.infoLight,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppPalette(
      primary: l(primary, other.primary),
      background: l(background, other.background),
      scaffoldBackground: l(scaffoldBackground, other.scaffoldBackground),
      surface: l(surface, other.surface),
      surfaceVariant: l(surfaceVariant, other.surfaceVariant),
      card: l(card, other.card),
      textPrimary: l(textPrimary, other.textPrimary),
      textSecondary: l(textSecondary, other.textSecondary),
      textMuted: l(textMuted, other.textMuted),
      border: l(border, other.border),
      divider: l(divider, other.divider),
      disabled: l(disabled, other.disabled),
      disabledText: l(disabledText, other.disabledText),
      successLight: l(successLight, other.successLight),
      warningLight: l(warningLight, other.warningLight),
      errorLight: l(errorLight, other.errorLight),
      infoLight: l(infoLight, other.infoLight),
      shadow: l(shadow, other.shadow),
    );
  }
}

/// [AppTypography] styles re-coloured for the active [AppPalette].
class AppTextStyles {
  const AppTextStyles(this._c);

  final AppPalette _c;

  TextStyle get heading1 =>
      AppTypography.heading1.copyWith(color: _c.textPrimary);
  TextStyle get heading2 =>
      AppTypography.heading2.copyWith(color: _c.textPrimary);
  TextStyle get bodyLarge =>
      AppTypography.bodyLarge.copyWith(color: _c.textSecondary);
  TextStyle get bodyMedium =>
      AppTypography.bodyMedium.copyWith(color: _c.textSecondary);
  TextStyle get labelMedium =>
      AppTypography.labelMedium.copyWith(color: _c.textPrimary);
  TextStyle get buttonText => AppTypography.buttonText;
}

extension AppThemeContext on BuildContext {
  AppPalette get colors =>
      Theme.of(this).extension<AppPalette>() ?? AppPalette.light;

  AppTextStyles get typography => AppTextStyles(colors);

  BrandTheme get brand =>
      Theme.of(this).extension<BrandTheme>() ?? BrandTheme.light;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
