import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/colors_manager.dart';

class ThemeManager {
  static ThemeData light = ThemeData();
  static ThemeData dark = ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      foregroundColor: ColorsManager.orange,
      backgroundColor: ColorsManager.black121312,
      iconTheme: IconThemeData(color: ColorsManager.orange),
    ),
    tabBarTheme: TabBarTheme(
      tabAlignment: TabAlignment.start,
      labelPadding: REdgeInsets.only(right: 8),
      labelColor: ColorsManager.black121312,
      unselectedLabelColor: ColorsManager.orange,
      indicatorColor: Colors.transparent,
      dividerColor: Colors.transparent,
      labelStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: ColorsManager.black121312,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: ColorsManager.orange,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: REdgeInsets.symmetric(vertical: 18),
      hintStyle: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ColorsManager.white,
      ),
      prefixIconColor: ColorsManager.white,
      suffixIconColor: ColorsManager.white,
      filled: true,
      fillColor: ColorsManager.black282A28,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.black282A28),
        borderRadius: BorderRadius.circular(16.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.black282A28),
        borderRadius: BorderRadius.circular(16.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorsManager.black282A28),
        borderRadius: BorderRadius.circular(16.r),
      ),
    ),
    scaffoldBackgroundColor: ColorsManager.black121312,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManager.orange,
      unselectedItemColor: ColorsManager.white,
      backgroundColor: ColorsManager.black282A28,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
        color: ColorsManager.white,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.roboto(
        color: ColorsManager.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: GoogleFonts.roboto(
        color: ColorsManager.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.roboto(
        color: ColorsManager.gray,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: GoogleFonts.roboto(
        color: ColorsManager.orange,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.roboto(
        color: ColorsManager.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: GoogleFonts.roboto(
        color: ColorsManager.black121312,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
