import 'package:go_router/go_router.dart';
import 'package:summit_parts/features/brand/ui/screen/brands_list_screen.dart';
import 'package:summit_parts/features/home_navigation/ui/screen/home_navigation_screen.dart';
import 'package:summit_parts/features/part/ui/screen/parts_list_screen.dart';

final router = GoRouter(
  initialLocation: HomeNavigationScreen.path,
  routes: [
    GoRoute(
      path: HomeNavigationScreen.path,
      builder: (context, state) => const HomeNavigationScreen(),
      routes: [
        GoRoute(path: BrandsListScreen.path, builder: (context, state) => const BrandsListScreen()),
        GoRoute(path: PartsListScreen.path, builder: (context, state) => const PartsListScreen()),
      ],
    ),
  ],
);
