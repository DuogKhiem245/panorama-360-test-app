import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Khám phá Không gian',
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: CupertinoTheme.of(context).textTheme.textStyle.color,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Đắm chìm trong không gian 360°\nchân thực và sống động.',
          style: TextStyle(
            fontSize: 14.sp,
            height: 1.35,
            color: CupertinoTheme.of(context).textTheme.textStyle.color,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
