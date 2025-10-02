import 'package:flutter/material.dart';
import 'package:movies_app/mainLayout/data/api_services.dart';
import 'package:movies_app/mainLayout/data/models/movie_data_model.dart';

class SearchTabViewModel extends ChangeNotifier {
  List<MovieDataModel> moviesList = [];
  String error = '';

  void getMoviesBySearch({String query = ''}) async {
    var result = await ApiServices.getMovies(query: query, limit: 20);
    result.fold(
      (left) {
        moviesList = left;
        notifyListeners();
      },
      (right) {
        error = right;
        notifyListeners();
      },
    );
  }
}
