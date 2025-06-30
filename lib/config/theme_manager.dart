import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/colors_manager.dart';

class ThemeManager {
  static ThemeData light = ThemeData();
  static ThemeData dark = ThemeData(
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
        labelMedium: GoogleFonts.roboto(
          color: ColorsManager.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        labelSmall: GoogleFonts.roboto(
          color: ColorsManager.orange,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ));
}
