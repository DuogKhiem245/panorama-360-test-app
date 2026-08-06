import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class HomeSearchBarWidget extends StatelessWidget {
  const HomeSearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48.h,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: CupertinoTheme.of(context).barBackgroundColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: CupertinoTheme.of(
                  context,
                ).textTheme.textStyle.color!.withValues(alpha: 0.3),
                width: 1.2.w,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.search,
                  size: 20.sp,
                  color: CupertinoTheme.of(
                    context,
                  ).textTheme.textStyle.color?.withValues(alpha: .7),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CupertinoTextField(
                    placeholder: 'Tìm kiếm địa điểm, triển lãm...',
                    placeholderStyle: TextStyle(
                      color: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color?.withValues(alpha: 0.7),
                      fontSize: 14.sp,
                    ),
                    decoration: null,
                    padding: EdgeInsets.zero,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: CupertinoTheme.of(context).barBackgroundColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: CupertinoTheme.of(
                  context,
                ).textTheme.textStyle.color!.withValues(alpha: 0.3),
                width: 1.2.w,
              ),
            ),
            child: Icon(
              CupertinoIcons.slider_horizontal_3,
              size: 20.sp,
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
          ),
        ),
      ],
    );
  }
}
