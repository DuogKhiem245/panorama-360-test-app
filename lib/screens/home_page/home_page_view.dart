import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:panorama_360_test_app/providers/scene_provider.dart';
import 'package:panorama_360_test_app/screens/home_page/widget/featured_experience_card.dart';
import 'package:panorama_360_test_app/screens/home_page/widget/home_header_widget.dart';
import 'package:panorama_360_test_app/screens/home_page/widget/home_search_bar_widget.dart';
import 'package:panorama_360_test_app/screens/home_page/widget/recent_additions_section.dart';

class HomePageView extends ConsumerStatefulWidget {
  const HomePageView({super.key});

  @override
  ConsumerState<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends ConsumerState<HomePageView> {
  @override
  Widget build(BuildContext context) {
    final scenesAsync = ref.watch(scenesProvider);
    final featuredSceneAsync = ref.watch(featuredSceneProvider);

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
              HomeHeaderWidget(),
              SizedBox(height: 20.h),

              HomeSearchBarWidget(),
              SizedBox(height: 24),

              featuredSceneAsync.when(
                data: (featuredScene) {
                  if (featuredScene == null) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      FeaturedExperienceCard(
                        scene: featuredScene,
                        onOpen360Tap: () {
                          // Navigator.of(context).push(
                          //   CupertinoPageRoute(
                          //     builder: (context) => PanoramaScreen(scene: featuredScene),
                          //   ),
                          // );
                        },
                      ),
                      SizedBox(height: 28.h),
                    ],
                  );
                },
                loading: () => Container(
                  height: 320.h,
                  alignment: Alignment.center,
                  child: const CupertinoActivityIndicator(),
                ),
                error: (err, stack) => const SizedBox.shrink(),
              ),

              scenesAsync.when(
                data: (scenes) => RecentAdditionsSection(scenes: scenes),
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
