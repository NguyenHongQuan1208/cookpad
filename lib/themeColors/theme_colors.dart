import 'package:flutter/material.dart';

class ThemeColors {
  ThemeColors._();

  // ─── Light Mode ───
  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFff992a),
    primaryContainer: Color(0xFFffb889),
    secondary: Color(0xFFffd9c5),
    secondaryContainer: Color(0xFFffede5),
    surface: Color(0xFFFFFFFF),
    surfaceContainerHighest: Color(0xFFEEEEEE), // grey.shade200 replacement
    surfaceContainerHigh: Color(0xFFF5F5F5), // grey.shade100 replacement
    error: Color(0xFFB00020),
    onPrimary: Colors.white,
    onSecondary: Color(0xFF000000),
    onSurface: Color(0xFF000000),
    onSurfaceVariant: Color(0xFF757575), // grey.shade600 / textSecondary
    onError: Colors.white,
    outline: Color(0xFF9E9E9E), // Colors.grey replacement
    outlineVariant: Color(0xFFBDBDBD), // grey.shade400
    shadow: Color(0xFF000000),
    tertiary: Color(0xFFFFC107), // Colors.amber replacement (premium icon)
  );

  // ─── Dark Mode ───
  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFffb060),
    primaryContainer: Color(0xFFcc7a22),
    secondary: Color(0xFF5c3d2e),
    secondaryContainer: Color(0xFF3e2a1f),
    surface: Color(0xFF1C1B1F),
    surfaceContainerHighest: Color(0xFF3A3A3A),
    surfaceContainerHigh: Color(0xFF2C2C2C),
    error: Color(0xFFCF6679),
    onPrimary: Color(0xFF000000),
    onSecondary: Color(0xFFFFFFFF),
    onSurface: Color(0xFFE6E1E5),
    onSurfaceVariant: Color(0xFFCAC4D0),
    onError: Color(0xFF000000),
    outline: Color(0xFF938F99),
    outlineVariant: Color(0xFF49454F),
    shadow: Color(0xFF000000),
    tertiary: Color(0xFFFFD54F),
  );
}
