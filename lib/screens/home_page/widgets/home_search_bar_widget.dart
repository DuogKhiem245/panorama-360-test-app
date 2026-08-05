import 'package:flutter/cupertino.dart';
import 'package:panorama_360_test_app/core/constants/app_color.dart';

class HomeSearchBarWidget extends StatelessWidget {
  const HomeSearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    return Row(
      children: [
        // Input text field container
        Expanded(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.card(isDark),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.border(isDark),
                width: 1.2,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.search,
                  size: 20,
                  color: AppColors.textSecondary(isDark),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CupertinoTextField(
                    placeholder: 'Tìm kiếm địa điểm, triển lãm...',
                    placeholderStyle: TextStyle(
                      color: AppColors.textSecondary(isDark),
                      fontSize: 14,
                    ),
                    decoration: null,
                    padding: EdgeInsets.zero,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary(isDark),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.card(isDark),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.border(isDark),
                width: 1.2,
              ),
            ),
            child: Icon(
              CupertinoIcons.slider_horizontal_3,
              size: 20,
              color: AppColors.textPrimary(isDark),
            ),
          ),
        ),
      ],
    );
  }
}

