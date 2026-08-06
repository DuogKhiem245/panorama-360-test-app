import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
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
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).barBackgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: CupertinoTheme.of(
              context,
            ).textTheme.textStyle.color!.withValues(alpha: 0.1),
            width: 1.0.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180.h,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
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
                                    color: CupertinoTheme.of(
                                      context,
                                    ).textTheme.textStyle.color,
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
                                    color: CupertinoTheme.of(
                                      context,
                                    ).barBackgroundColor,
                                    child: Center(
                                      child: Icon(
                                        CupertinoIcons.photo,
                                        color: CupertinoTheme.of(context)
                                            .textTheme
                                            .textStyle
                                            .color!
                                            .withValues(alpha: 0.7),
                                        size: 36.sp,
                                      ),
                                    ),
                                  ),
                            ),
                    ),
                    Positioned(
                      top: 10.h,
                      left: 10.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: CupertinoTheme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          badgeText,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.eye,
                            size: 15,
                            color: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.color!.withValues(alpha: 0.7),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            viewsText,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .color!
                                  .withValues(alpha: 0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        locationText,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.color!.withValues(alpha: 0.7),
                          fontWeight: FontWeight.w500,
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
