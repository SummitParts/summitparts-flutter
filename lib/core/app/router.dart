import 'package:go_router/go_router.dart';
import 'package:summit_parts/features/home/ui/screen/home_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [GoRoute(path: '/', builder: (context, state) => const HomeScreen())],
);
