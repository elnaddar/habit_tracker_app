import 'package:flutter/material.dart';

/// Light ColorScheme for #176FEA
const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF176FEA),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD6E2FF),
  onPrimaryContainer: Color(0xFF001A43),
  secondary: Color(0xFF575E71),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFDAE2F9),
  onSecondaryContainer: Color(0xFF151B2C),
  tertiary: Color(0xFF715573),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFBD7FC),
  onTertiaryContainer: Color(0xFF29132E),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF410002),
  surface: Color(0xFFFEFBFF),
  onSurface: Color(0xFF1B1B1E),
  surfaceContainerHighest: Color(0xFFE1E2EC),
  onSurfaceVariant: Color(0xFF44474F),
  outline: Color(0xFF75777F),
  shadow: Color(0xFF000000),
  inverseSurface: Color(0xFF303034),
  onInverseSurface: Color(0xFFF2F0F4),
  inversePrimary: Color(0xFFAAC6FF),
  surfaceTint: Color(0xFF176FEA),
);

ThemeData lightMode = ThemeData(
  useMaterial3: true, // Optional: Enables Material 3 APIs
  colorScheme: lightColorScheme,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
  ),
  // You can add typography, etc. here if needed
);
