import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme getAppTextTheme(Brightness brightness) {
  final baseTextTheme = brightness == Brightness.dark 
      ? ThemeData.dark().textTheme 
      : ThemeData.light().textTheme;
  
  return GoogleFonts.poppinsTextTheme(baseTextTheme).copyWith(
    bodyLarge: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  );
}
