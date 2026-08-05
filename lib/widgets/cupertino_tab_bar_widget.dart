import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:panorama_360_test_app/models/tab_items.dart';
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
      backgroundColor: const Color(0xFF14171F),
      child: Stack(
        children: [
          IndexedStack(index: selectedIndex, children: _pages),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomCupertinoTabBar(),
          ),
        ],
      ),
    );
  }
}

class CustomCupertinoTabBar extends ConsumerWidget {
  const CustomCupertinoTabBar({super.key});

  static const List<TabItemData> _items = [
    TabItemData(
      label: 'Home',
      icon: CupertinoIcons.house,
      activeIcon: CupertinoIcons.house_fill,
    ),
    TabItemData(
      label: 'Explore',
      icon: CupertinoIcons.compass,
      activeIcon: CupertinoIcons.compass_fill,
    ),
    TabItemData(
      label: 'Favorites',
      icon: CupertinoIcons.heart,
      activeIcon: CupertinoIcons.heart_fill,
    ),
    TabItemData(
      label: 'Profile',
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
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.05),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.08),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
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
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Hiệu ứng co giãn Icon khi active (Bounce effect)
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
                              ? const Color(
                                  0xFFEFF6FF,
                                ) // Nền Highlight Xanh nhạt
                              : Colors.transparent,
                        ),
                        child: Icon(
                          isSelected ? item.activeIcon : item.icon,
                          size: 20.sp,
                          color: isSelected
                              ? const Color(0xFF2563EB) // Blue Hoàng Gia
                              : const Color(0xFF64748B), // Slate Grey
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    // Label Text với hiệu ứng chuyển màu
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? const Color(0xFF2563EB)
                            : const Color(0xFF64748B),
                        letterSpacing: -0.2,
                        fontFamily: '.SF Pro Text',
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
