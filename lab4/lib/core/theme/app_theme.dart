import 'package:flutter/material.dart';

/// Paleta aplicației (gym store).
const Color kGreen = Color(0xFF5CC466);
const Color kGreenDark = Color(0xFF3E9C4C);
const Color kDark = Color(0xFF14161C);
const Color kDarkSoft = Color(0xFF23262F);
const Color kGrey = Color(0xFF8A8F9C);
const Color kGreyLight = Color(0xFFB9BDC7);
const Color kBackground = Color(0xFFF4F5F8);
const Color kCard = Colors.white;
const Color kDanger = Color(0xFFE5484D);
const Color kAmber = Color(0xFFF5A623);
const Color kFieldFill = Color(0xFFEDEFF3);

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: kGreen,
    primary: kGreen,
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
        color: kDark,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: kDark,
      ),
      bodyMedium: TextStyle(fontSize: 13.5, color: kDarkSoft, height: 1.45),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: kGreen,
        foregroundColor: kDark,
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),
  );
}
