import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextTheme {
  MyTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    displayMedium: GoogleFonts.montserrat(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.w500,
    ),

    titleMedium: GoogleFonts.montserrat(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),

    titleSmall: GoogleFonts.montserrat(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayMedium: GoogleFonts.montserrat(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),

    titleLarge: GoogleFonts.montserrat(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),

    titleMedium: GoogleFonts.montserrat(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: GoogleFonts.montserrat(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );
}
