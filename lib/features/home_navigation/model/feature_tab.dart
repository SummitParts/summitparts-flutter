import 'package:flutter/material.dart';
import 'package:summit_parts/features/home/ui/screen/home_screen.dart';

enum FeatureTab {
  dashboard(label: 'Home', icon: Icons.home_filled, screen: HomeScreen()),
  account(label: 'Account', icon: Icons.home_filled, screen: Scaffold());

  const FeatureTab({required this.label, required this.icon, required this.screen});

  final String label;
  final IconData icon;
  final Widget screen;
}
