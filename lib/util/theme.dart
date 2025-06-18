import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waterapp/util/color.dart';

ThemeData getDarkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColor.primarydark,
    progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.onprimarydark,
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColor.secondarydark,
      primary: AppColor.primarydark,
      onPrimary: AppColor.onprimarydark,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.sora(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: GoogleFonts.sora(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: GoogleFonts.sora(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
