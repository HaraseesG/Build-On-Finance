import 'package:flutter/material.dart';

/// UI chrome colors — cards, chips, progress fills, text, backgrounds.
///
/// Never use these for chart marks (donut segments, bar fills, line/area
/// strokes, legends) — see [AppChartColors] for that palette. The two were
/// validated separately: this pastel set reads well as chrome but fails a
/// categorical-chart color validator (lightness/chroma/CVD separation).
class AppColors {
  AppColors._();

  // Neutrals
  static const Color bg = Color(0xFFF8F3E9);
  static const Color textPrimary = Color(0xFF1F2B24);
  static const Color textSecondary = Color(0xFF5C6B60);
  static const Color border = Color(0xFFECE1CB);
  static const Color divider = Color(0xFFF1EBDC);
  static const Color borderStrong = Color(0xFFD8CCA8);

  // Semantic
  static const Color success = Color(0xFF3F8055);
  static const Color danger = Color(0xFFBA3B3E);
  static const Color dangerOnWash = Color(0xFF8A2A2C);
  static const Color dangerFill = Color(0xFFEB7473);
  static const Color focusRing = Color(0xFF2F5A3D);

  // Pastel category palette — green (Rent/primary)
  static const Color greenFill = Color(0xFFA8D3B6);
  static const Color greenBorder = Color(0xFFB9DCC3);
  static const Color greenText = Color(0xFF2F5A3D);
  static const Color greenTextLight = Color(0xFF6FA97F);
  static const Color greenWash = Color(0xFFE4F1E7);

  // Pastel category palette — orange (Groceries)
  static const Color orangeFill = Color(0xFFF5C3A0);
  static const Color orangeText = Color(0xFF8A5A28);
  static const Color orangeTextMid = Color(0xFFB8763F);
  static const Color orangeTextLight = Color(0xFFE6A06C);
  static const Color orangeWash = Color(0xFFF9E4CE);

  // Pastel category palette — blue (Transport)
  static const Color blueFill = Color(0xFFB3C2E8);
  static const Color blueText = Color(0xFF4D5F8A);
  static const Color blueTextLight = Color(0xFF8AA0DB);
  static const Color blueWash = Color(0xFFDEE5F5);

  // Pastel category palette — red/coral (Dining, over-budget)
  static const Color redFill = Color(0xFFEB7473);
  static const Color redText = Color(0xFF8A2A2C);
  static const Color redTextMid = Color(0xFFBA3B3E);
  static const Color redWash = Color(0xFFFBE1E1);
  static const Color redWashAlt = Color(0xFFF7D9DA);
}

/// Chart-mark-only categorical palette — donut segments, bar fills, chart
/// legends, line/area strokes. Deliberately separate from [AppColors]'
/// pastel category palette, which fails as chart data (lightness, chroma,
/// and colorblind-separation checks). Every use must still pair a color
/// with a direct text label (legend row, axis label, adjacent number) —
/// colorblind adjacent-pair separation here is a warning, not a full pass,
/// and only holds up when labeled.
class AppChartColors {
  AppChartColors._();

  static const Color green = Color(
    0xFF2E8659,
  ); // Rent / within budget / positive
  static const Color orange = Color(0xFFC4823D); // Groceries
  static const Color blue = Color(0xFF4C64C2); // Transport / debt series 3
  static const Color red = Color(0xFFBA3B3E); // Dining / over budget / negative
}
