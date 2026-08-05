import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panorama_360_test_app/core/constants/app_color.dart';

class RecentAdditionCard extends StatelessWidget {
  final String imageUrl;
  final String badgeText;
  final String title;
  final String viewsText;
  final String locationText;
  final VoidCallback? onTap;

  const RecentAdditionCard({
    super.key,
    required this.imageUrl,
    required this.badgeText,
    required this.title,
    required this.viewsText,
    required this.locationText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.card(isDark),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.border(isDark) : Colors.transparent,
            width: isDark ? 1.0 : 0,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image Container with Badge
            SizedBox(
              height: 180,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: isDark
                              ? const Color(0xFF334155)
                              : const Color(0xFFE2E8F0),
                          child: Center(
                            child: Icon(
                              CupertinoIcons.photo,
                              color: isDark
                                  ? Colors.white54
                                  : const Color(0xFF94A3B8),
                              size: 36,
                            ),
                          ),
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: isDark
                                ? const Color(0xFF1E293B)
                                : const Color(0xFFF1F5F9),
                            child: const Center(
                              child: CupertinoActivityIndicator(),
                            ),
                          );
                        },
                      ),
                    ),
                    // Badge Overlay
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF0F172A).withValues(alpha: 0.9)
                              : Colors.white.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          badgeText,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? const Color(0xFF38BDF8)
                                : const Color(0xFF0284C7),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Content Section
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary(isDark),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.eye,
                            size: 15,
                            color: AppColors.textSecondary(isDark),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            viewsText,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary(isDark),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        locationText,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary(isDark),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

