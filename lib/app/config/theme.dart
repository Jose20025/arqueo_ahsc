import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeConfig {
  static const primaryColor = Color(0xFF5FD068);
  static const secondaryColor = Color(0xFF4B8673);
  static const backgroundColor = Color(0xFFF6FBF4);

  static ThemeData getTheme() => ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: primaryColor,
        fontFamily: GoogleFonts.poppins().fontFamily,

        // Scaffold background color
        scaffoldBackgroundColor: backgroundColor,

        // Appbar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),

        // floatingActionButton Theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: secondaryColor,
          foregroundColor: Colors.white,
        ),

        // Filled button theme
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(secondaryColor),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            textStyle: MaterialStateProperty.all(
              const TextStyle(fontWeight: FontWeight.w600),
            ),
            elevation: MaterialStateProperty.all(1),
          ),
        ),

        // Icon button theme
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(secondaryColor),
          ),
        ),

        // Card theme
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );
}
