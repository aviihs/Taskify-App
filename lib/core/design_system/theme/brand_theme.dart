import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

/// Theme extension for custom brand tokens, gradients, and elevation styling.
class BrandTheme extends ThemeExtension<BrandTheme> {
  const BrandTheme({
    required this.primaryGradient,
    required this.heroGradient,
    required this.cardGradient,
    required this.glassGradient,
    required this.glassBorderColor,
    required this.shimmerBaseColor,
    required this.shimmerHighlightColor,
  });

  final LinearGradient primaryGradient;
  final LinearGradient heroGradient;
  final LinearGradient cardGradient;
  final LinearGradient glassGradient;
  final Color glassBorderColor;
  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;

  static final BrandTheme light = BrandTheme(
    primaryGradient: AppGradients.primary,
    heroGradient: AppGradients.hero,
    cardGradient: AppGradients.card,
    glassGradient: AppGradients.glass,
    glassBorderColor: const Color(0x33FFFFFF),
    shimmerBaseColor: const Color(0xFFE8EAF4),
    shimmerHighlightColor: const Color(0xFFF8F9FD),
  );

  static final BrandTheme dark = BrandTheme(
    primaryGradient: const LinearGradient(
      colors: [Color(0xFF686FB1), Color(0xFF585C83)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    heroGradient: const LinearGradient(
      colors: [Color(0xFF1E2130), Color(0xFF2E334D)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    cardGradient: const LinearGradient(
      colors: [Color(0xFF25293C), Color(0xFF1F2232)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    glassGradient: const LinearGradient(
      colors: [Color(0x1AFFFFFF), Color(0x05FFFFFF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    glassBorderColor: const Color(0x1EFFFFFF),
    shimmerBaseColor: const Color(0xFF2B2F44),
    shimmerHighlightColor: const Color(0xFF383D58),
  );

  @override
  BrandTheme copyWith({
    LinearGradient? primaryGradient,
    LinearGradient? heroGradient,
    LinearGradient? cardGradient,
    LinearGradient? glassGradient,
    Color? glassBorderColor,
    Color? shimmerBaseColor,
    Color? shimmerHighlightColor,
  }) {
    return BrandTheme(
      primaryGradient: primaryGradient ?? this.primaryGradient,
      heroGradient: heroGradient ?? this.heroGradient,
      cardGradient: cardGradient ?? this.cardGradient,
      glassGradient: glassGradient ?? this.glassGradient,
      glassBorderColor: glassBorderColor ?? this.glassBorderColor,
      shimmerBaseColor: shimmerBaseColor ?? this.shimmerBaseColor,
      shimmerHighlightColor:
          shimmerHighlightColor ?? this.shimmerHighlightColor,
    );
  }

  @override
  BrandTheme lerp(ThemeExtension<BrandTheme>? other, double t) {
    if (other is! BrandTheme) return this;
    return BrandTheme(
      primaryGradient: LinearGradient.lerp(
        primaryGradient,
        other.primaryGradient,
        t,
      )!,
      heroGradient: LinearGradient.lerp(heroGradient, other.heroGradient, t)!,
      cardGradient: LinearGradient.lerp(cardGradient, other.cardGradient, t)!,
      glassGradient: LinearGradient.lerp(
        glassGradient,
        other.glassGradient,
        t,
      )!,
      glassBorderColor: Color.lerp(
        glassBorderColor,
        other.glassBorderColor,
        t,
      )!,
      shimmerBaseColor: Color.lerp(
        shimmerBaseColor,
        other.shimmerBaseColor,
        t,
      )!,
      shimmerHighlightColor: Color.lerp(
        shimmerHighlightColor,
        other.shimmerHighlightColor,
        t,
      )!,
    );
  }
}
