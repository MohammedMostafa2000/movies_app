import 'package:flutter/material.dart';
import 'package:movies_app/core/colors_manager.dart';

class ThemeManager {
  static ThemeData light = ThemeData();
  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: ColorsManager.black121312,
  );
}
