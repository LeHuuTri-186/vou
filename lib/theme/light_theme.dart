import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'text/nunito_style.dart';
import 'color/colors.dart';
import 'text/work_sans_style.dart';
import 'app_bar_theme.dart';
import 'bottom_nav_theme.dart';

class LightTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: TColor.doctorWhite,
      scaffoldBackgroundColor: TColor.doctorWhite,
      appBarTheme: AppBarThemeData.lightTheme,
      textTheme: TextTheme(
        titleLarge: NunitoStyle.titleW800,
        titleMedium: NunitoStyle.titleW700.copyWith(
          fontSize: 22, // Medium-sized titles
          color: TColor.slate,
        ),
        titleSmall: NunitoStyle.titleW600.copyWith(
          fontSize: 18, // Consistent for smaller subtitles
          color: TColor.petRock,
        ),
        displayLarge: GoogleFonts.varelaRound(
          fontWeight: FontWeight.w800,
          fontSize: 32, // Balanced for display headers
          color: TColor.squidInk,
        ),
        displayMedium: WorkSansStyle.basic.copyWith(
          fontSize: 28,
        ),
        headlineLarge: GoogleFonts.varelaRound(
          fontSize: 40, // Adjusted headline size
          fontWeight: FontWeight.bold,
          color: TColor.squidInk,
        ),
        headlineSmall: GoogleFonts.varelaRound(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: TColor.squidInk,
        ),
        bodyLarge: GoogleFonts.varelaRound(
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
        bodyMedium: GoogleFonts.varelaRound(
          fontSize: 14, // Standard size for body text
          color: TColor.petRock,
        ),
      ),
      bottomNavigationBarTheme: BottomNavThemeData.lightTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: TColor.royalBlue,
          textStyle: GoogleFonts.varelaRound(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: TColor.doctorWhite,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
    );
  }
}
