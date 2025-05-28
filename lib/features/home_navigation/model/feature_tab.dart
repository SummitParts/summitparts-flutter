import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:summit_parts/features/auth/ui/screen/user_screen.dart';
import 'package:summit_parts/features/catalog/ui/screen/catalog_screen.dart';
import 'package:summit_parts/features/home/ui/screen/home_screen.dart';
import 'package:summit_parts/features/resources/ui/screen/resources_screen.dart';

enum FeatureTab {
  dashboard(label: 'Home', icon: FontAwesomeIcons.house, screen: HomeScreen()),
  specials(
    label: 'Specials',
    icon: FontAwesomeIcons.tags,
    screen: CatalogScreen(id: 'specials'),
  ),
  resources(label: 'Resources', icon: FontAwesomeIcons.circleInfo, screen: ResourcesScreen()),
  account(label: 'Account', icon: FontAwesomeIcons.userLarge, screen: UserScreen());

  const FeatureTab({required this.label, required this.icon, required this.screen});

  final String label;
  final IconData icon;
  final Widget screen;
}
