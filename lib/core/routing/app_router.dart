import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:summit_parts/features/catalog/model/product.dart';
import 'package:summit_parts/features/catalog/ui/screen/catalog_screen.dart';
import 'package:summit_parts/features/catalog/ui/screen/product_screen.dart';
import 'package:summit_parts/features/home_navigation/ui/screen/home_navigation_screen.dart';
import 'package:summit_parts/features/search/ui/screen/search_screen.dart';

final router = GoRouter(
  initialLocation: HomeNavigationScreen.path,
  routes: [
    GoRoute(
      path: HomeNavigationScreen.path,
      builder: (context, state) => const HomeNavigationScreen(),
      routes: [
        GoRoute(
          path: CatalogScreen.path,
          builder: (context, state) => CatalogScreen(id: state.pathParameters['id'] as String),
        ),
        GoRoute(path: ProductScreen.path, builder: (context, state) => ProductScreen(product: state.extra as Product)),
        GoRoute(
          path: SearchScreen.path,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const SearchScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return const FadeUpwardsPageTransitionsBuilder().buildTransitions(
                  null,
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                );
              },
            );
          },
        ),
      ],
    ),
  ],
);
