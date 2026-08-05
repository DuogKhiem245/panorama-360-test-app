import 'package:flutter/material.dart';
import 'recent_addition_card.dart';

class RecentAdditionsSection extends StatelessWidget {
  const RecentAdditionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Recent Additions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        SizedBox(height: 12),
        RecentAdditionCard(
          imageUrl:
              'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?q=80&w=800&auto=format&fit=crop',
          badgeText: 'Exhibition',
          title: 'Abstract Forms Gallery',
          viewsText: '1.2k views',
          locationText: 'Berlin, DE',
        ),
        SizedBox(height: 16),
        RecentAdditionCard(
          imageUrl:
              'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?q=80&w=800&auto=format&fit=crop',
          badgeText: 'Architecture',
          title: 'Central Library Archive',
          viewsText: '845 views',
          locationText: 'London, UK',
        ),
      ],
    );
  }
}
