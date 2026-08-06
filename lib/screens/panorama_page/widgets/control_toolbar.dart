import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:panorama_360_test_app/models/scene_model.dart';

class ControlToolbar extends StatelessWidget {
  // final double currentZoom;
  // final VoidCallback onZoomIn;
  // final VoidCallback onZoomOut;
  final VoidCallback onResetView;
  final String currentSceneId;
  final List<SceneModel> availableScenes;
  final Function(SceneModel) onSelectScene;

  const ControlToolbar({
    super.key,
    // required this.currentZoom,
    // required this.onZoomIn,
    // required this.onZoomOut,
    required this.onResetView,
    required this.currentSceneId,
    required this.availableScenes,
    required this.onSelectScene,
  });

  @override
  Widget build(BuildContext context) {
    // final isMinZoom = currentZoom <= 1.0;
    // final isMaxZoom = currentZoom >= 5.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onResetView,
            child: Container(
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Icon(
                CupertinoIcons.refresh,
                size: 20.sp,
                color: CupertinoColors.black,
              ),
            ),
          ),

          _buildDivider(),

          // Container(
          //   decoration: BoxDecoration(
          //     color: CupertinoColors.white,
          //     borderRadius: BorderRadius.circular(12.r),
          //   ),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       CupertinoButton(
          //         padding: EdgeInsets.symmetric(
          //           horizontal: 12.w,
          //           vertical: 10.h,
          //         ),
          //         minimumSize: Size.zero,
          //         onPressed: isMinZoom ? null : onZoomOut,
          //         child: Icon(
          //           CupertinoIcons.minus,
          //           size: 20.sp,
          //           color: isMinZoom
          //               ? CupertinoColors.systemGrey4
          //               : CupertinoColors.black,
          //         ),
          //       ),
          //       Container(
          //         width: 1,
          //         height: 16.h,
          //         color: CupertinoColors.systemGrey4,
          //       ),
          //       CupertinoButton(
          //         padding: EdgeInsets.symmetric(
          //           horizontal: 12.w,
          //           vertical: 10.h,
          //         ),
          //         minimumSize: Size.zero,
          //         onPressed: isMaxZoom ? null : onZoomIn,
          //         child: Icon(
          //           CupertinoIcons.add,
          //           size: 20.sp,
          //           color: isMaxZoom
          //               ? CupertinoColors.systemGrey4
          //               : CupertinoColors.black,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          // _buildDivider(),

          GestureDetector(
            onTap: () => _showScenesBottomSheet(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: const Color(0xFF0052D4),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.photo_fill_on_rectangle_fill,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Các không gian khác (${availableScenes.length})',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      width: 1,
      height: 20.h,
      color: CupertinoColors.systemGrey,
    );
  }

  void _showScenesBottomSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F5F9),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            Text(
              'Các cảnh tại địa điểm này (${availableScenes.length})',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.h),

            Expanded(
              child: availableScenes.isEmpty
                  ? Center(
                      child: Text(
                        'Không có không gian khác',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black45,
                        ),
                      ),
                    )
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: availableScenes.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 12.w),
                      itemBuilder: (context, index) {
                        final item = availableScenes[index];
                        final isSelected = item.id == currentSceneId;

                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            onSelectScene(item);
                          },
                          child: Column(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 110.w,
                                    height: 110.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF0052D4)
                                            : Colors.transparent,
                                        width: 3,
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage(item.thumbnailUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      top: 6.w,
                                      right: 6.w,
                                      child: Container(
                                        padding: EdgeInsets.all(4.w),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF0052D4),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          CupertinoIcons.checkmark_alt,
                                          color: Colors.white,
                                          size: 14.sp,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              SizedBox(
                                width: 110.w,
                                child: Text(
                                  item.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? const Color(0xFF0052D4)
                                        : Colors.black87,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
