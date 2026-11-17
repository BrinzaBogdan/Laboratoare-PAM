import 'package:flutter/material.dart';

/// Paleta aplicației de learning.
const Color kAccent = Color(0xFFFF6F00);
const Color kAccentSoft = Color(0xFFFFE0CC);
const Color kAccentDark = Color(0xFFE05F00);
const Color kInk = Color(0xFF101012);
const Color kInkSoft = Color(0xFF3A3C44);
const Color kMuted = Color(0xFF7E858C);
const Color kMutedLight = Color(0xFFB4B9BF);
const Color kBackground = Color(0xFFF7F8FA);
const Color kCard = Colors.white;
const Color kFieldFill = Color(0xFFF0F1F4);
const Color kDivider = Color(0xFFE8EAED);
const Color kDanger = Color(0xFFE5484D);
const Color kAmber = Color(0xFFFFB300);
const Color kSuccess = Color(0xFF20C766);

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: kAccent,
    primary: kAccent,
    surface: kCard,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: kBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: kBackground,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: kInk,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: kInk,
      ),
      bodyMedium: TextStyle(fontSize: 13.5, color: kInkSoft, height: 1.5),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: kAccent,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),
  );
}
