import 'package:flutter/material.dart';

import 'widget/featured_experience_card.dart';
import 'widget/home_header_widget.dart';
import 'widget/home_search_bar_widget.dart';
import 'widget/recent_additions_section.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: 100, // Extra space at bottom for floating Cupertino Tab Bar
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // Header Section
              HomeHeaderWidget(),
              SizedBox(height: 20),

              // Search & Filter Bar Section
              HomeSearchBarWidget(),
              SizedBox(height: 24),

              // Featured Experience Hero Card
              FeaturedExperienceCard(),
              SizedBox(height: 28),

              // Recent Additions List Section
              RecentAdditionsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
