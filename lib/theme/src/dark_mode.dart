import 'package:flutter/material.dart';


/// Dark ColorScheme for #176FEA
const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFAAC6FF),
  onPrimary: Color(0xFF002E6D),
  primaryContainer: Color(0xFF004398),
  onPrimaryContainer: Color(0xFFD6E2FF),
  secondary: Color(0xFFBDC6DC),
  onSecondary: Color(0xFF2A3042),
  secondaryContainer: Color(0xFF414659),
  onSecondaryContainer: Color(0xFFDCE2F9),
  tertiary: Color(0xFFDCBDE0),
  onTertiary: Color(0xFF3C2842),
  tertiaryContainer: Color(0xFF54405A),
  onTertiaryContainer: Color(0xFFFBD7FC),
  error: Color(0xFFFFB4AB),
  onError: Color(0xFF690005),
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: Color(0xFF1B1B1E),
  onSurface: Color(0xFFE4E2E6),
  surfaceContainerHighest: Color(0xFF44474F),
  onSurfaceVariant: Color(0xFFC4C6D0),
  outline: Color(0xFF8E9099),
  shadow: Color(0xFF000000),
  inverseSurface: Color(0xFFE4E2E6),
  onInverseSurface: Color(0xFF1B1B1E),
  inversePrimary: Color(0xFF176FEA),
  surfaceTint: Color(0xFFAAC6FF),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
  ),
);