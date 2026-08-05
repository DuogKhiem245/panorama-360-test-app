import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPageView extends StatelessWidget {
  const SearchPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1C2230), Color(0xFF12151D)],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF8AAEFF).withValues(alpha: 0.12),
                  border: Border.all(
                    color: const Color(0xFF8AAEFF).withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  CupertinoIcons.search,
                  size: 56,
                  color: Color(0xFF8AAEFF),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Search Screen',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Cupertino Style Bottom Navigation Bar',
                style: TextStyle(fontSize: 14, color: Color(0xFF8E97A4)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
