import 'package:flutter/material.dart';

class AppUi {
  AppUi._();

  // ===========================================================================
  // Border Radius
  // ===========================================================================

  static const double radiusXS = 6;
  static const double radiusSM = 10;
  static const double radiusMD = 16;
  static const double radiusLG = 20;
  static const double radiusXL = 28;
  static const double radiusXXL = 36;
  static const double radiusCircle = 999;

  // Default
  static const double borderRadius = radiusMD;
  static const double cardRadius = radiusXL;

  // ===========================================================================
  // Padding
  // ===========================================================================

  static const double paddingXS = 4;
  static const double paddingSM = 8;
  static const double paddingMD = 16;
  static const double paddingLG = 20;
  static const double paddingXL = 24;
  static const double paddingXXL = 32;

  // ===========================================================================
  // Margin
  // ===========================================================================

  static const double marginSM = 8;
  static const double marginMD = 16;
  static const double marginLG = 24;

  // ===========================================================================
  // Heights
  // ===========================================================================

  static const double buttonHeight = 56;
  static const double inputHeight = 56;
  static const double appBarHeight = 60;
  static const double bottomNavHeight = 70;

  // ===========================================================================
  // Icons
  // ===========================================================================

  static const double iconXS = 16;
  static const double iconSM = 20;
  static const double iconMD = 24;
  static const double iconLG = 28;
  static const double iconXL = 36;

  static const double iconSize = iconLG;

  // ===========================================================================
  // Avatar
  // ===========================================================================

  static const double avatarXS = 32;
  static const double avatarSM = 40;
  static const double avatarMD = 48;
  static const double avatarLG = 60;
  static const double avatarXL = 80;

  static const double avatarSize = avatarMD;

  // ===========================================================================
  // Decorative
  // ===========================================================================

  static const double decorativeOrbLarge = 220;
  static const double decorativeOrbMedium = 180;
  static const double decorativeOrbSmall = 120;

  // ===========================================================================
  // Animation
  // ===========================================================================

  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  // ===========================================================================
  // Input Border
  // ===========================================================================

  static const OutlineInputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    borderSide: BorderSide.none,
  );

  static OutlineInputBorder outlinedBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius),
    borderSide: BorderSide(color: color, width: 1.2),
  );

  // ===========================================================================
  // Shadows
  // ===========================================================================

  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 24,
    spreadRadius: 0,
    offset: Offset(0, 12),
  );

  static const BoxShadow softShadow = BoxShadow(
    color: Color(0x0D000000),
    blurRadius: 12,
    offset: Offset(0, 6),
  );

  static const BoxShadow buttonShadow = BoxShadow(
    color: Color(0x25585C83),
    blurRadius: 18,
    offset: Offset(0, 8),
  );

  static const BoxShadow floatingShadow = BoxShadow(
    color: Color(0x33000000),
    blurRadius: 30,
    offset: Offset(0, 18),
  );

  // ===========================================================================
  // Blur
  // ===========================================================================

  static const double glassBlur = 18;
  static const double glassOpacity = .18;
}

/// Minimal elevation — prefer surface contrast over heavy shadows.
abstract final class AppShadows {
  static const List<BoxShadow> none = [];

  /// Hairline depth for grouped list cards (Manage, categories).
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x08000000),
      blurRadius: 12,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> sm = card;

  static const List<BoxShadow> md = [
    BoxShadow(color: Color(0x0C000000), blurRadius: 16, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(color: Color(0x10000000), blurRadius: 24, offset: Offset(0, 8)),
  ];

  /// FAB / floating CTA — brand-colored, very subtle.
  static List<BoxShadow> primaryGlow(Color primary) => [
    BoxShadow(
      color: primary.withValues(alpha: 0.22),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];
}
