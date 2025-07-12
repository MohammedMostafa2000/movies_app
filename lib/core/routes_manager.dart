import 'package:flutter/material.dart';
import 'package:movies_app/mainLayout/presentation/views/mainlayout_view.dart';
import 'package:movies_app/mainLayout/presentation/views/movie_details_view.dart';

class RoutesManager {
  static const String mainLayoutView = '/mainLayoutScreen';
  static const String movieDetailsView = '/movieDetailsView';

  static Route<dynamic>? goRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainLayoutView:
        return MaterialPageRoute(builder: (context) => MainlayoutView());
      case movieDetailsView:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => MovieDetailsView(movieId: settings.arguments as int),
        );

      default:
        return null;
    }
  }
}
