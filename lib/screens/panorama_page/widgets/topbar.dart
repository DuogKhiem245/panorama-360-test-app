
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:panorama_360_test_app/models/scene_model.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.scene,
  });

  final SceneModel scene;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 16,
      right: 16,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(24.sp),
              ),
              child: Icon(
                CupertinoIcons.back,
                color:
                    CupertinoTheme.of(context).textTheme.textStyle.color,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Container(
              height: 40.w,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(24.sp),
              ),
              child: Text(
                scene.title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: CupertinoTheme.of(
                    context,
                  ).textTheme.textStyle.color,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
