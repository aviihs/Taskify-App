import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------------
  // Brand Colors
  // ---------------------------------------------------------------------------

  static const Color primary = Color(0xFF585C83);
  static const Color primaryLight = Color(0xFF7A7EA3);
  static const Color primaryDark = Color(0xFF3E425F);

  static const Color secondary = Color(0xFF686FB1);
  static const Color secondaryLight = Color(0xFF8A90C8);
  static const Color secondaryDark = Color(0xFF4D5491);

  static const Color accent = Color(0xFF8C93D9);

  // ---------------------------------------------------------------------------
  // Background
  // ---------------------------------------------------------------------------

  static const Color background = Color(0xFFF6F7FB);
  static const Color scaffoldBackground = Color(0xFFF2F4F9);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFE8EAF4);
  static const Color card = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------------
  // Text
  // ---------------------------------------------------------------------------

  static const Color textPrimary = Color(0xFF1F2435);
  static const Color textSecondary = Color(0xFF5F6785);
  static const Color textMuted = Color(0xFF9097B3);
  static const Color textWhite = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------------
  // Status
  // ---------------------------------------------------------------------------

  static const Color success = Color(0xFF22C55E);
  static const Color successLight = Color(0xFFDCFCE7);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);

  // ---------------------------------------------------------------------------
  // Border
  // ---------------------------------------------------------------------------

  static const Color border = Color(0xFFD8DCEB);
  static const Color divider = Color(0xFFE6E9F2);

  // ---------------------------------------------------------------------------
  // Disabled
  // ---------------------------------------------------------------------------

  static const Color disabled = Color(0xFFC2C7DA);
  static const Color disabledText = Color(0xFF9CA3AF);

  // ---------------------------------------------------------------------------
  // Misc
  // ---------------------------------------------------------------------------

  static const Color shadow = Color(0x1A000000);
  static const Color overlay = Color(0x66000000);
}

class AppGradients {
  AppGradients._();

  // ===========================================================================
  // BRAND
  // ===========================================================================

  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary, AppColors.secondary],
  );

  static const LinearGradient hero = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primaryDark, AppColors.primary, AppColors.secondary],
    stops: [0.0, 0.45, 1.0],
  );

  static const LinearGradient accent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.secondary, AppColors.accent],
  );

  // ===========================================================================
  // BUTTONS
  // ===========================================================================

  static const LinearGradient button = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.primary, Color(0xFF7077BC)],
  );

  static const LinearGradient buttonPressed = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.primaryDark, AppColors.primary],
  );

  // ===========================================================================
  // BACKGROUND
  // ===========================================================================

  static const LinearGradient background = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF8F9FD), Color(0xFFEDEFF7)],
  );

  static const LinearGradient softPurple = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF6F7FB), Color(0xFFE8EAF4), Color(0xFFDDE1F8)],
  );

  static const LinearGradient scaffold = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFF2F4F9)],
  );

  // ===========================================================================
  // CARD
  // ===========================================================================

  static const LinearGradient card = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFF3F5FB)],
  );

  static const LinearGradient premiumCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF686FB1), Color(0xFF585C83)],
  );

  // ===========================================================================
  // DRAWER / SIDEBAR
  // ===========================================================================

  static const LinearGradient drawer = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.primaryDark, AppColors.primary],
  );

  // ===========================================================================
  // STATUS
  // ===========================================================================

  static const LinearGradient success = LinearGradient(
    colors: [Color(0xFF22C55E), Color(0xFF4ADE80)],
  );

  static const LinearGradient warning = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
  );

  static const LinearGradient danger = LinearGradient(
    colors: [Color(0xFFEF4444), Color(0xFFF87171)],
  );

  static const LinearGradient info = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
  );

  // ===========================================================================
  // GLASS EFFECT
  // ===========================================================================

  static const LinearGradient glass = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x33FFFFFF), Color(0x11FFFFFF)],
  );

  static const LinearGradient whiteGlass = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xCCFFFFFF), Color(0x99FFFFFF)],
  );

  // ===========================================================================
  // SPECIAL
  // ===========================================================================

  static const LinearGradient shimmer = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFE8EAF4), Color(0xFFF8F9FD), Color(0xFFE8EAF4)],
  );

  static const LinearGradient avatar = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary, AppColors.accent],
  );

  static const LinearGradient appBar = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary, AppColors.secondary],
  );

  static const LinearGradient bottomBar = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFF2F4F9)],
  );
}
