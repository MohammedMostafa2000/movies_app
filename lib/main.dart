import 'package:flutter/material.dart';
import 'package:movies_app/config/theme_manager.dart';
import 'package:movies_app/core/routes_manager.dart';

void main() {
  runApp(MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesManager.goRoute,
      initialRoute: RoutesManager.mainLayoutView,
      locale: Locale('en'),
      theme: ThemeManager.light,
      darkTheme: ThemeManager.dark,
      themeMode: ThemeMode.dark,
    );
  }
}
