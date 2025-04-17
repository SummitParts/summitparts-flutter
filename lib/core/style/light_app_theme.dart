import 'package:flutter/material.dart';
import 'package:summit_parts/core/style/app_theme.dart';
import 'package:summit_parts/gen/fonts.gen.dart';

final ThemeData lightTheme = _LightAppTheme().theme();

@immutable
class _LightAppTheme extends AppTheme {
  @override
  ThemeData theme() {
    final colorScheme = ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color(0xFF0C71C3),
      surface: const Color(0xFFF8F8F8),
      onSurface: const Color(0xFF171717),
    );

    return ThemeData(fontFamily: FontFamily.poppins, brightness: Brightness.light, colorScheme: colorScheme);
  }
}
