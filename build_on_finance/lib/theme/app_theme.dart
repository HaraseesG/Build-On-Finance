import 'package:flutter/material.dart';

import 'app_colors.dart';

/// App-wide [ThemeData], built from [AppColors].
///
/// Newsreader carries hero numbers/titles; Public Sans carries everything
/// else. Never mix the two within one text element.
class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.success,
        brightness: Brightness.light,
        primary: AppColors.success,
        error: AppColors.danger,
        surface: AppColors.bg,
      ),
      textTheme: const TextTheme(
        // Hero figure — e.g. "$2,140" on Home.
        displayMedium: TextStyle(
          fontFamily: 'Newsreader',
          fontWeight: FontWeight.w500,
          fontSize: 42,
          color: AppColors.textPrimary,
        ),
        // Page/dialog title — e.g. "Settings", sheet titles.
        titleLarge: TextStyle(
          fontFamily: 'Newsreader',
          fontWeight: FontWeight.w500,
          fontSize: 22,
          color: AppColors.textPrimary,
        ),
        // Stat figure (card) — e.g. net worth, goal balances.
        titleMedium: TextStyle(
          fontFamily: 'Newsreader',
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: AppColors.textPrimary,
        ),
        // Body — list rows, descriptions.
        bodyMedium: TextStyle(
          fontFamily: 'Public Sans',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
        // Label / meta — timestamps, section eyebrows.
        bodySmall: TextStyle(
          fontFamily: 'Public Sans',
          fontWeight: FontWeight.w600,
          fontSize: 11,
          color: AppColors.textSecondary,
        ),
        // Eyebrow (uppercase section headers, e.g. "DEBT PAYOFF").
        labelSmall: TextStyle(
          fontFamily: 'Public Sans',
          fontWeight: FontWeight.w700,
          fontSize: 10,
          letterSpacing: 0.5,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
