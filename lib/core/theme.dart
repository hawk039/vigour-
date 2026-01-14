import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color lavenderSoft = Color(0xFFE6E6FA);
  static const Color dustyRose = Color(0xFFF4C2C2);
  static const Color charcoalDeep = Color(0xFF2F2F2F);
  static const Color navyDeep = Color(0xFF1B263B);
  static const Color pastelAmber = Color(0xFFFFE4B5);
  static const Color pastelCoral = Color(0xFFFFB7B2);
  static const Color pastelPearl = Color(0xFFFDFCF0);
  static const Color coralPeach = Color(0xFFFFCBA4);

  // New colors from Favorites design
  static const Color twilightLavender = Color(0xFFE0E7FF);
  static const Color twilightPeach = Color(0xFFFFEDD5);
  static const Color roseGold = Color(0xFFE29578);
  static const Color darkNavy = Color(0xFF1E293B);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: lavenderSoft,
      primary: navyDeep,
    ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
      displayLarge: GoogleFonts.playfairDisplay(
        color: charcoalDeep,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
      bodyLarge: GoogleFonts.plusJakartaSans(
        color: navyDeep,
        fontSize: 16,
      ),
    ),
  );

  static const BoxDecoration backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: [lavenderSoft,roseGold],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  static const BoxDecoration twilightGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFFF3E8FF), Color(0xFFFFEDD5)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
}
