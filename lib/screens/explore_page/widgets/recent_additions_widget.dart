import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panorama_360_test_app/core/constants/app_color.dart';
import 'package:panorama_360_test_app/models/scene_model.dart';
import 'package:panorama_360_test_app/screens/panorama_page/panorama_page_view.dart';

class RecentAdditionsWidget extends StatelessWidget {
  const RecentAdditionsWidget({super.key, required this.scenes});

  final List<SceneModel> scenes;

  @override
  Widget build(BuildContext context) {
    if (scenes.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: scenes.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final scene = scenes[index];

            return RecentAdditionCard(
              imageUrl: scene.thumbnailUrl,
              badgeText: scene.category,
              title: scene.title,
              viewsText: '${scene.hotspots.length} điểm tương tác', 
              locationText: scene.location,
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => PanoramaPageView(scene: scene),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

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
                      child: imageUrl.startsWith('http')
                          ? ExtendedImage.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              cache: true,
                              loadStateChanged: (state) {
                                if (state.extendedImageLoadState ==
                                    LoadState.loading) {
                                  return Container(
                                    color: isDark
                                        ? const Color(0xFF1E293B)
                                        : const Color(0xFFF1F5F9),
                                    child: const Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  );
                                }
                                return null;
                              },
                            )
                          : Image.asset(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
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
                            ),
                    ),
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