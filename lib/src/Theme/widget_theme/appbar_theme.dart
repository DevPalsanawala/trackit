import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:trackit/src/constants/color.dart';

class DAppbarTheme {
  DAppbarTheme._();

  static AppBarTheme lightAppbarTheme = AppBarTheme(
    backgroundColor: Color(0xFFF0F0F0),
    titleTextStyle: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );
  static AppBarTheme darkAppbarTheme = AppBarTheme(
    backgroundColor: Color(0XFF101010),
    titleTextStyle: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}
