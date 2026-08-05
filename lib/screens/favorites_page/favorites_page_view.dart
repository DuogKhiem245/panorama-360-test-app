import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panorama_360_test_app/core/constants/app_color.dart';

class FavoritesPageView extends StatelessWidget {
  const FavoritesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.bg(isDark),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF0284C7).withValues(alpha: 0.1),
                  border: Border.all(
                    color: const Color(0xFF0284C7).withValues(alpha: 0.25),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  CupertinoIcons.heart_fill,
                  size: 56,
                  color: Color(0xFF0284C7),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Màn hình Yêu thích',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary(isDark),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Không gian & Triển lãm đã lưu của bạn',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary(isDark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

