import 'package:go_router/go_router.dart';
import 'package:summit_parts/features/home_navigation/ui/screen/home_navigation_screen.dart';

final router = GoRouter(
  initialLocation: HomeNavigationScreen.path,
  routes: [GoRoute(path: HomeNavigationScreen.path, builder: (context, state) => const HomeNavigationScreen())],
);
