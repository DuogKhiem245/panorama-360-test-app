import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:panorama_360_test_app/models/hotspot_model.dart';

class HotspotItem extends StatelessWidget {
  final HotspotModel hotspot;

  const HotspotItem({super.key, required this.hotspot});

  @override
  Widget build(BuildContext context) {
    final isNav = hotspot.type == HotspotType.navigation;

    return GestureDetector(
      onTap: () => _onHotspotTap(context, hotspot),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isNav
              ? const Color(0xFF0088CC).withValues(alpha: 0.85)
              : const Color(0xFF38BDF8).withValues(alpha: 0.85),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: (isNav ? const Color(0xFF0088CC) : const Color(0xFF38BDF8))
                  .withValues(alpha: 0.6),
              blurRadius: 12,
              spreadRadius: 2,
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Chuyển hướng không gian sang: ${hotspot.targetSceneId}',
          ),
        ),
      );
    }
  }
}