import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/authentication/presentation/viewModels/login_view_model.dart';
import 'package:movies_app/authentication/presentation/viewModels/register_view_model.dart';
import 'package:movies_app/config/theme_manager.dart';
import 'package:movies_app/core/routes_manager.dart';
import 'package:movies_app/mainLayout/presentation/viewModels/movie_details_view_model.dart';
import 'package:movies_app/mainLayout/presentation/viewModels/profile_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MovieDetailsViewModel()),
      ChangeNotifierProvider(create: (context) => RegisterViewModel()),
      ChangeNotifierProvider(create: (context) => LoginViewModel()),
      ChangeNotifierProvider(create: (context) => ProfileViewModel()),
    ],
    child: MoviesApp(),
  ));
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(context.width, context.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesManager.goRoute,
        initialRoute: RoutesManager.mainLayoutView,
        locale: Locale('en'),
        theme: ThemeManager.light,
        darkTheme: ThemeManager.dark,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}

extension ContextEx on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
}
