import 'package:flutter/cupertino.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF3B82F6);

  static const Color lightBg = Color(0xFFFFFFFF);
  static const Color darkBg = Color(0xFF121212);

  static const Color lightCard = Color(0xFFf5f8f8);
  static const Color darkCard = Color(0xFF1E1E1E);

  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color darkBorder = Color(0xFF334155);

  static const Color textLightBg = Color(0xFF0F172A);
  static const Color textDarkBg = Color(0xFFF8FAFC);
  static const Color textSubLightBg = Color(0xFF64748B);
  static const Color textSubDarkBg = Color(0xFF94A3B8);

  static Color bg(bool isDark) => isDark ? darkBg : lightBg;
  static Color card(bool isDark) => isDark ? darkCard : lightCard;
  static Color border(bool isDark) => isDark ? darkBorder : lightBorder;
  static Color textPrimary(bool isDark) => isDark ? textDarkBg : textLightBg;
  static Color textSecondary(bool isDark) =>
      isDark ? textSubDarkBg : textSubLightBg;
}
