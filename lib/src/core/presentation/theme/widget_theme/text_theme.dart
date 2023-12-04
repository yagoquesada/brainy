import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/* -- Light Text Theme -- */
TextTheme lightTextTheme = TextTheme(
  displayLarge: GoogleFonts.montserrat(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  displayMedium: GoogleFonts.montserrat(
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  ),
  displaySmall: GoogleFonts.poppins(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  ),
  headlineMedium: GoogleFonts.poppins(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.black45,
  ),
  titleLarge: GoogleFonts.poppins(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  ),
  bodyLarge: GoogleFonts.poppins(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  ),
  bodyMedium: GoogleFonts.poppins(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  ),
);

/* -- Dark Text Theme -- */
TextTheme darkTextTheme = TextTheme(
  displayLarge: GoogleFonts.montserrat(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  displayMedium: GoogleFonts.montserrat(
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  ),
  displaySmall: GoogleFonts.poppins(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  ),
  headlineMedium: GoogleFonts.poppins(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
  titleLarge: GoogleFonts.poppins(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
  bodyLarge: GoogleFonts.poppins(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  ),
  bodyMedium: GoogleFonts.poppins(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  ),
);
