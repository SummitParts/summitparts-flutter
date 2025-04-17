import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/features/home_navigation/logic/current_screen_provider.dart';
import 'package:summit_parts/features/home_navigation/model/feature_tab.dart';

class HomeNavigationScreen extends ConsumerWidget {
  const HomeNavigationScreen({super.key});

  static const String path = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScreen = ref.watch(currentScreenProvider);

    return _EagerInitialization(
      child: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          ref.read(currentScreenProvider.notifier).state = FeatureTab.dashboard;
        },
        canPop: currentScreen.index == 0,
        child: Scaffold(
          body: currentScreen.screen,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentScreen.index,
            onTap: (index) {
              ref.read(currentScreenProvider.notifier).state = FeatureTab.values[index];
            },
            items:
                FeatureTab.values
                    .map(
                      (featureTab) => BottomNavigationBarItem(
                        icon: Icon(featureTab.icon),
                        label: featureTab.label,
                      ),
                    )
                    .toList(),
          ),
        ),
      ),
    );
  }
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return child;
  }
}
