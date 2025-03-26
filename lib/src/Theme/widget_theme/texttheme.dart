import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DtextTheme {
  DtextTheme._();
  static TextTheme lightTextTheme = TextTheme(
    // headline1
    headlineLarge: GoogleFonts.ubuntu(
      color: Colors.black87,
      fontSize: 30,
      fontWeight: FontWeight.w800,
    ),
    // headline2
    headlineMedium: GoogleFonts.ubuntu(
      color: Colors.black87,
      fontSize: 28,
      fontWeight: FontWeight.w900,
    ),
    // headline3
    headlineSmall: GoogleFonts.ubuntu(
      color: Colors.black87,
      fontSize: 18,
      fontWeight: FontWeight.w900,
    ),
    //headline4
    titleLarge: GoogleFonts.ubuntu(
      color: Colors.black87,
      fontSize: 16,
    ),
    //bodyText1
    bodyLarge: GoogleFonts.ubuntu(
      color: Colors.black,
      fontSize: 16,

      // fontWeight: FontWeight.w500,
    ),
    // bodyText2
    bodyMedium: GoogleFonts.ubuntu(
      color: Colors.black26,
      fontSize: 14,

      // fontWeight: FontWeight.w500,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.ubuntu(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.w900,
    ),
    headlineMedium: GoogleFonts.ubuntu(
      color: Colors.white,
      fontSize: 28,
      fontWeight: FontWeight.w900,
    ),
    headlineSmall: GoogleFonts.ubuntu(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w900,
    ),
    titleLarge: GoogleFonts.ubuntu(
      color: Colors.white,
      fontSize: 16,
    ),
    bodyLarge: GoogleFonts.ubuntu(
      color: Colors.white60,
      fontSize: 16,

      // fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.ubuntu(
      color: Colors.white30,
      fontSize: 14,

      // fontWeight: FontWeight.w500,
    ),
  );
}
