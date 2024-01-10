import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  static ThemeData getLightTheme() => ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );

  static ThemeData getDarkTheme() => ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
        fontFamily: GoogleFonts.poppins().fontFamily,
      );
}
