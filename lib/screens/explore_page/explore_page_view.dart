import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:panorama_360_test_app/providers/scene_provider.dart';
import 'package:panorama_360_test_app/screens/explore_page/widgets/recent_additions_widget.dart';

class ExplorePageView extends ConsumerStatefulWidget {
  const ExplorePageView({super.key});

  @override
  ConsumerState<ExplorePageView> createState() => _ExplorePageViewState();
}

class _ExplorePageViewState extends ConsumerState<ExplorePageView> {
  @override
  Widget build(BuildContext context) {
    final scenesAsync = ref.watch(scenesProvider);

    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 16.h,
            bottom: 100.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Không gian & Môi trường 360°',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 20.h),
              scenesAsync.when(
                data: (scenes) => RecentAdditionsWidget(scenes: scenes),
                loading: () =>
                    const Center(child: CupertinoActivityIndicator()),
                error: (err, stack) => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
