import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/core/routing/app_router.dart';
import 'package:summit_parts/core/style/light_app_theme.dart';
import 'package:summit_parts/core/ui/widget/generic_error.dart';

class SummitPartsApp extends ConsumerWidget {
  const SummitPartsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Summit Parts',
      theme: lightTheme,
      builder: (context, child) {
        ErrorWidget.builder = (error) => GenericError(exception: Exception(error.exception));
        return child!;
      },
      routerConfig: ref.watch(routerProvider),
    );
  }
}
