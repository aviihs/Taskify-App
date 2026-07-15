import 'package:flutter/material.dart';

class AppUi {
  AppUi._();

  static const double borderRadius = 16;
  static const double cardRadius = 28;
  static const double avatarSize = 48;
  static const double decorativeOrbLarge = 220;
  static const double decorativeOrbSmall = 260;
  static const double iconSize = 28;

  static const OutlineInputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    borderSide: BorderSide.none,
  );

  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x1F000000),
    blurRadius: 24,
    offset: Offset(0, 16),
  );
}

