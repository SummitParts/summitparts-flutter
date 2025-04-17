import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:summit_parts/features/home/ui/screen/home_screen.dart';

enum FeatureTab {
  dashboard(label: 'Home', icon: FontAwesomeIcons.house, screen: HomeScreen()),
  account(label: 'Account', icon: FontAwesomeIcons.userLarge, screen: Scaffold());

  const FeatureTab({required this.label, required this.icon, required this.screen});

  final String label;
  final IconData icon;
  final Widget screen;
}
