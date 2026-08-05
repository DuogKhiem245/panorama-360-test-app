import 'package:flutter/cupertino.dart';
import 'package:panorama_360_test_app/core/theme/app_color.dart';

class AppTheme {
  static CupertinoThemeData getTheme(
    String fontFamily,
    Brightness brightness,
    Color accentColor,
  ) {
    final isDark = brightness == Brightness.dark;

    final textColor = isDark ? AppColors.textDarkBg : AppColors.textLightBg;

    return CupertinoThemeData(
      brightness: brightness,
      primaryColor: accentColor,
      primaryContrastingColor: accentColor,
      scaffoldBackgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      barBackgroundColor: isDark ? AppColors.darkCard : AppColors.lightCard,
      textTheme: CupertinoTextThemeData(primaryColor: textColor),
    );
  }
}
