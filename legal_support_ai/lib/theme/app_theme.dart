import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF0D0D0F);
  static const Color surface = Color(0xFF1A1A1F);
  static const Color surfaceVariant = Color(0xFF232328);
  static const Color primary = Color(0xFF7B5EA7);
  static const Color primaryLight = Color(0xFF9B7EC8);
  static const Color primaryDark = Color(0xFF5C3F82);
  static const Color userBubble = Color(0xFF6B4F9E);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8E8E9A);
  static const Color textTertiary = Color(0xFF5A5A6A);
  static const Color divider = Color(0xFF2A2A32);
  static const Color inputBackground = Color(0xFF1E1E26);
  static const Color iconBackground = Color(0xFF2A2535);
  static const Color greenOnline = Color(0xFF4CAF50);
  static const Color toggleActive = Color(0xFF7B5EA7);
  static const Color cardBackground = Color(0xFF1C1C22);
  static const Color bottomNavBackground = Color(0xFF111116);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.surface,
        background: AppColors.background,
      ),
      fontFamily: 'SF Pro Display',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.bottomNavBackground,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
