import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeSearchBarWidget extends StatelessWidget {
  const HomeSearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Input text field container
        Expanded(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1.2,
              ),
            ),
            child: Row(
              children: const [
                Icon(
                  CupertinoIcons.search,
                  size: 20,
                  color: Color(0xFF94A3B8),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CupertinoTextField(
                    placeholder: 'Search venues, galleries, h...',
                    placeholderStyle: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 14,
                    ),
                    decoration: null,
                    padding: EdgeInsets.zero,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Filter button
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1.2,
              ),
            ),
            child: const Icon(
              CupertinoIcons.slider_horizontal_3,
              size: 20,
              color: Color(0xFF334155),
            ),
          ),
        ),
      ],
    );
  }
}
