import 'package:flutter/material.dart';
import 'package:movies_app/mainLayout/presentation/views/mainlayout_view.dart';

class RoutesManager {
  static const String mainLayoutView = '/mainLayoutScreen';

  static Route<dynamic>? goRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainLayoutView:
        return MaterialPageRoute(builder: (context) => MainlayoutView());

      default:
        return null;
    }
  }
}
