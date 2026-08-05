import 'package:flutter/material.dart';
import 'package:panorama_360_test_app/core/constants/app_color.dart';
import 'package:panorama_360_test_app/models/scene_model.dart';
import 'recent_addition_card.dart';

class RecentAdditionsSection extends StatelessWidget {
  const RecentAdditionsSection({super.key, required this.scenes});

  final List<SceneModel> scenes;

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mới thêm gần đây',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary(isDark),
          ),
        ),

        SizedBox(height: 12),
        RecentAdditionCard(
          imageUrl:
              'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?q=80&w=800&auto=format&fit=crop',
          badgeText: 'Triển lãm',
          title: 'Phòng trưng bày Trừu tượng',
          viewsText: '1.2k lượt xem',
          locationText: 'Berlin, DE',
        ),
        SizedBox(height: 16),
        RecentAdditionCard(
          imageUrl:
              'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?q=80&w=800&auto=format&fit=crop',
          badgeText: 'Kiến trúc',
          title: 'Kho lưu trữ Thư viện Trung tâm',
          viewsText: '845 lượt xem',
          locationText: 'London, UK',
        ),
      ],
    );
  }
}
