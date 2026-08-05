import 'package:flutter/material.dart';

/// Unified corner radius — cards, inputs, sheets, chips share this scale.
abstract final class AppRadius {
  static const double xs = 4;
  static const double sm = 6;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 16;
  static const double xxl = 20;
  static const double sheet = 20;
  static const double full = 999;

  /// Unified radius for cards / buttons / inputs / search fields / chips
  /// The single
  /// tier every surface-level control resolves to. [sheet] (bottom-sheet
  /// top corners, 20) is a deliberate, separate exception, not this.
  static const double control = 8;

  /// Alias kept for existing call sites that still say `AppRadius.card` —
  /// same value as [control], not a separate tier. Prefer [control] in new
  /// code; this only exists so pre-Step-2 call sites don't need touching
  /// one-by-one to pick up the unification.
  static const double card = control;

  static const BorderRadius xsBr = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius smBr = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdBr = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgBr = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius xlBr = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius xxlBr = BorderRadius.all(Radius.circular(xxl));
  static const BorderRadius cardBr = BorderRadius.all(Radius.circular(card));
  static const BorderRadius controlBr = BorderRadius.all(
    Radius.circular(control),
  );
  static const BorderRadius sheetBr = BorderRadius.vertical(
    top: Radius.circular(sheet),
  );
  static const BorderRadius fullBr = BorderRadius.all(Radius.circular(full));
}
