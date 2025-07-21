import 'package:flutter/material.dart';
import 'package:movies_app/authentication/presentation/views/login.dart';
import 'package:movies_app/authentication/presentation/views/register.dart';
import 'package:movies_app/mainLayout/presentation/views/mainlayout_view.dart';
import 'package:movies_app/mainLayout/presentation/views/movie_details_view.dart';

class RoutesManager {
  static const String mainLayoutView = '/mainLayoutScreen';
  static const String movieDetailsView = '/movieDetailsView';
  static const String loginView = '/loginView';
  static const String registerView = '/registerView';

  static Route<dynamic>? goRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainLayoutView:
        return MaterialPageRoute(builder: (context) => MainlayoutView());
      case movieDetailsView:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => MovieDetailsView(movieId: settings.arguments as int),
        );
      case loginView:
        return MaterialPageRoute(builder: (context) => Login());
      case registerView:
        return MaterialPageRoute(builder: (context) => Register());

      default:
        return null;
    }
  }
}
