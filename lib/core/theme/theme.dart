import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xffBC0063);
  static const Color secondaryColor = Color(0xffD9D9D9);
  static const Color errorColor = Color(0xffb00020);
  static const Color kgreyColor = Color(0xffA9A9A9);

  static ThemeData defaultTheme() {
    return ThemeData.light().copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xffffffff),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryColor,
      ),
      textTheme: GoogleFonts.jostTextTheme().copyWith(
        titleLarge: TextStyle(
          fontFamily: GoogleFonts.jost().fontFamily,
          fontSize: 32.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: 16.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        headlineLarge: TextStyle(
          fontSize: 48.sp,
          fontFamily: GoogleFonts.jost().fontFamily,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      colorScheme: const ColorScheme.light().copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
        error: errorColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            fontFamily: GoogleFonts.jost().fontFamily,
            fontSize: 19.sp,
            fontWeight: FontWeight.bold,
          ),
          shape: const StadiumBorder(),
          // minimumSize: Size(174.w, 51.h),
        ),
      ),
    );
  }
}
