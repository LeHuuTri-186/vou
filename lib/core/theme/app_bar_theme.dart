import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/styles/colors.dart';

class AppBarThemeData {
  static AppBarTheme get lightTheme => AppBarTheme(
    backgroundColor: TColor.doctorWhite,
    scrolledUnderElevation: 0.0,
  );

  static AppBarTheme get darkTheme => AppBarTheme(
    backgroundColor: TColor.slate,
    scrolledUnderElevation: 0.0,
  );
}