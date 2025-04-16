import 'package:flutter/material.dart';
import 'package:summit_parts/core/app/router.dart';
import 'package:summit_parts/core/style/light_app_theme.dart';
import 'package:summit_parts/core/ui/widget/generic_error.dart';

class SummitPartsApp extends StatelessWidget {
  const SummitPartsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Summit Parts',
      theme: lightTheme,
      builder: (context, child) {
        ErrorWidget.builder = (error) => GenericError(exception: Exception(error.exception));
        return child!;
      },
      routerConfig: router,
    );
  }
}
