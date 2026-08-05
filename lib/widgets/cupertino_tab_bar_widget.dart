import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:panorama_360_test_app/models/tab_items_model.dart';
import 'package:panorama_360_test_app/providers/navigation_provider.dart';
import 'package:panorama_360_test_app/screens/explore_page/explore_page_view.dart';
import 'package:panorama_360_test_app/screens/favorites_page/favorites_page_view.dart';
import 'package:panorama_360_test_app/screens/home_page/home_page_view.dart';
import 'package:panorama_360_test_app/screens/profile_page/profile_page_view.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  static const List<Widget> _pages = [
    HomePageView(),
    ExplorePageView(),
    FavoritesPageView(),
    ProfilePageView(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationNotifierProvider);

    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          IndexedStack(index: selectedIndex, children: _pages),
          const Positioned(left: 0, right: 0, bottom: 0, child: CustomTabBar()),
        ],
      ),
    );
  }
}

class CustomTabBar extends ConsumerWidget {
  const CustomTabBar({super.key});

  static const List<TabItemData> _items = [
    TabItemData(
      label: 'Trang chủ',
      icon: CupertinoIcons.house,
      activeIcon: CupertinoIcons.house_fill,
    ),
    TabItemData(
      label: 'Khám phá',
      icon: CupertinoIcons.compass,
      activeIcon: CupertinoIcons.compass_fill,
    ),
    TabItemData(
      label: 'Yêu thích',
      icon: CupertinoIcons.heart,
      activeIcon: CupertinoIcons.heart_fill,
    ),
    TabItemData(
      label: 'Cá nhân',
      icon: CupertinoIcons.person,
      activeIcon: CupertinoIcons.person_fill,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationNotifierProvider);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (index) {
          final isSelected = selectedIndex == index;
          final item = _items[index];

          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                ref.read(navigationNotifierProvider.notifier).setIndex(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedScale(
                      scale: isSelected ? 1.15 : 1.0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutBack,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        width: 42.r,
                        height: 32.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: isSelected
                              ? CupertinoTheme.of(context).primaryColor
                              : Colors.transparent,
                        ),
                        child: Icon(
                          isSelected ? item.activeIcon : item.icon,
                          size: 20.sp,
                          color: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.color,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color,
                      ),
                      child: Text(item.label),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
