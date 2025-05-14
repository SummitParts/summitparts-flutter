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
      primary: const Color(0xFF0C71C3),
      surface: Colors.white,
      surfaceBright: const Color(0xFFF3F4F6),
      onSurface: const Color(0xFF171717),
      outlineVariant: const Color(0xFFE5E7EB),
    );

    const textTheme = TextTheme(
      headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    );

    return ThemeData(
      fontFamily: FontFamily.poppins,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.error),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
