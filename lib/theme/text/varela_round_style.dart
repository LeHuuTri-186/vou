import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkSansStyle {
  static TextStyle basic = GoogleFonts.workSans(
    color: Colors.black,
    fontSize: 14,
  );

  static TextStyle basicW600 = GoogleFonts.workSans(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static TextStyle title = GoogleFonts.workSans(
    color: Colors.black,
    fontSize: 26, // More distinct for titles compared to ABeeZee
  );

  static TextStyle titleW600 = GoogleFonts.workSans(
    color: Colors.black,
    fontSize: 26,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleW700 = GoogleFonts.workSans(
    color: Colors.black,
    fontSize: 26,
    fontWeight: FontWeight.w700,
  );

  static TextStyle titleW800 = GoogleFonts.workSans(
    color: Colors.black,
    fontSize: 26,
    fontWeight: FontWeight.w800,
  );
}
