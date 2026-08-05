import 'package:flutter/cupertino.dart';

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