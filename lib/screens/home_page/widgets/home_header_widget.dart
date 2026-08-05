import 'package:flutter/material.dart';
import 'package:panorama_360_test_app/core/constants/app_color.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Khám phá Không gian',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary(isDark),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Đắm chìm trong không gian 360°\nchân thực và sống động.',
          style: TextStyle(
            fontSize: 14,
            height: 1.35,
            color: AppColors.textSecondary(isDark),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

