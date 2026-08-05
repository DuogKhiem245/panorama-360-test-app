import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/navigation_provider.dart';
import '../screens/explore_page/explore_page_view.dart';
import '../screens/favorites_page/favorites_page_view.dart';
import '../screens/home_page/home_page_view.dart';
import '../screens/profile_page/profile_page_view.dart';
import '../screens/search_page/search_page_view.dart';

class TabItemData {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  const TabItemData({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}

/// Màn hình chính quản lý và cấu hình các tab
class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  static const List<Widget> _pages = [
    HomePageView(),
    ExplorePageView(),
    SearchPageView(),
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
          // Content of selected tab page
          IndexedStack(
            index: selectedIndex,
            children: _pages,
          ),
          // Floating Cupertino Tab Bar at the bottom
          const Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: CustomCupertinoTabBar(),
          ),
        ],
      ),
    );
  }
}

/// Widget thanh Tab Bar thiết kế theo Cupertino style
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
      label: 'Search',
      icon: CupertinoIcons.search,
      activeIcon: CupertinoIcons.search,
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF212530),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
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
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon Container with Glow Effect for Active state
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? const Color(0xFF8AAEFF)
                            : Colors.transparent,
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(
                                    0xFF8AAEFF,
                                  ).withValues(alpha: 0.55),
                                  blurRadius: 18,
                                  spreadRadius: 2,
                                ),
                              ]
                            : [],
                      ),
                      child: Icon(
                        isSelected ? item.activeIcon : item.icon,
                        size: isSelected ? 20 : 22,
                        color: isSelected
                            ? const Color(0xFF161922)
                            : const Color(0xFFD0D5E0),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Label Text
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? const Color(0xFFB0CDFF)
                            : const Color(0xFFD0D5E0),
                        letterSpacing: 0.2,
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
