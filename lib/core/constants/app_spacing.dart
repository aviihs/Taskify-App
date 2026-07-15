import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;

  static const EdgeInsets screenPadding = EdgeInsets.all(xl);
  static const EdgeInsets cardPadding = EdgeInsets.all(24);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets smallButtonPadding = EdgeInsets.symmetric(vertical: 14);
}
