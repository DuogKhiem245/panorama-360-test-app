import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:panorama_360_test_app/models/hotspot_model.dart';

class HotspotItem extends StatefulWidget {
  final HotspotModel hotspot;
  final void Function(String targetSceneId)? onNavigate;

  const HotspotItem({
    super.key,
    required this.hotspot,
    this.onNavigate,
  });

  @override
  State<HotspotItem> createState() => _HotspotItemState();
}

class _HotspotItemState extends State<HotspotItem> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.hotspot.type == HotspotType.navigation) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNav = widget.hotspot.type == HotspotType.navigation;

    return GestureDetector(
      onTap: () => _onHotspotTap(context, widget.hotspot),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: isNav ? _scaleAnimation.value : 1.0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isNav
                    ? const Color(0xFF0088CC).withValues(alpha: 0.9)
                    : const Color(0xFF38BDF8).withValues(alpha: 0.85),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: (isNav ? const Color(0xFF0088CC) : const Color(0xFF38BDF8))
                        .withValues(alpha: isNav ? 0.7 : 0.5),
                    blurRadius: isNav ? 16 : 12,
                    spreadRadius: isNav ? 3 : 2,
                  ),
                ],
              ),
              child: Icon(
                isNav
                    ? CupertinoIcons.arrow_right_arrow_left
                    : CupertinoIcons.info_circle_fill,
                color: Colors.white,
                size: 22.sp,
              ),
            ),
          );
        },
      ),
    );
  }

  void _onHotspotTap(BuildContext context, HotspotModel hotspot) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                hotspot.title,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
              ),
              if (hotspot.description.isNotEmpty) ...[
                SizedBox(height: 12.h),
                Text(
                  hotspot.description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF475569),
                    height: 1.5,
                  ),
                ),
              ],
              if (hotspot.imageUrl != null && hotspot.imageUrl!.isNotEmpty) ...[
                SizedBox(height: 16.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    hotspot.imageUrl!,
                    width: double.infinity,
                    height: 180.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),
              ],
              SizedBox(height: 20.h),
              if (hotspot.type == HotspotType.navigation &&
                  hotspot.targetSceneId != null &&
                  hotspot.targetSceneId!.isNotEmpty) ...[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    widget.onNavigate?.call(hotspot.targetSceneId!);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0052D4),
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0052D4).withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Đi vào không gian này',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          CupertinoIcons.arrow_right,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ],
          ),
        ),
      ),
    );
  }
}