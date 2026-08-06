import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:panorama_360_test_app/models/scene_model.dart';

class FeaturedExperienceCard extends StatelessWidget {
  final SceneModel? scene;
  final VoidCallback? onOpen360Tap;
  final VoidCallback? onViewAllTap;

  const FeaturedExperienceCard({
    super.key,
    this.scene,
    this.onOpen360Tap,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    if (scene == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trải nghiệm Nổi bật',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: CupertinoTheme.of(context).textTheme.textStyle.color,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          height: 320.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.black.withValues(alpha: 0.08),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Stack(
              children: [
                Positioned.fill(
                  child: scene!.thumbnailUrl.startsWith('http')
                      ? ExtendedImage.network(
                          scene!.thumbnailUrl,
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
                          scene!.thumbnailUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: const Color(0xFF334155),
                                child: const Center(
                                  child: Icon(
                                    CupertinoIcons.photo,
                                    color: CupertinoColors.white,
                                    size: 48,
                                  ),
                                ),
                              ),
                        ),
                ),

                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.4, 1.0],
                        colors: [
                          CupertinoColors.black.withValues(alpha: 0.2),
                          CupertinoColors.black.withValues(alpha: 0.05),
                          CupertinoColors.black.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 14.h,
                  left: 14.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const ContainerDot(),
                        SizedBox(width: 5.w),
                        Text(
                          'Trải nghiệm Hot',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  left: 16.w,
                  right: 16.w,
                  bottom: 16.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.location_solid,
                            size: 14.sp,
                            color: CupertinoColors.white,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            scene!.location,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        scene!.title,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                          onPressed: onOpen360Tap,
                          color: const Color(0xFF0088CC),
                          borderRadius: BorderRadius.circular(22.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.panorama_photosphere_outlined,
                                color: CupertinoColors.white,
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Mở 360°',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: CupertinoColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ContainerDot extends StatelessWidget {
  const ContainerDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.r,
      height: 8.r,
      decoration: const BoxDecoration(
        color: Color(0xFF38BDF8),
        shape: BoxShape.circle,
      ),
    );
  }
}
