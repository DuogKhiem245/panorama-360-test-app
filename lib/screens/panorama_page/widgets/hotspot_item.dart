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
    if (hotspot.type == HotspotType.info) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: Text(
            hotspot.title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          message: Text(hotspot.description),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng'),
            ),
          ],
        ),
      );
    } else if (hotspot.type == HotspotType.navigation) {
      if (hotspot.targetSceneId != null && hotspot.targetSceneId!.isNotEmpty) {
        widget.onNavigate?.call(hotspot.targetSceneId!);
      }
    }
  }
}