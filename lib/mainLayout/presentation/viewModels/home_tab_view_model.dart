import 'package:flutter/material.dart';
import 'package:movies_app/mainLayout/data/api_services.dart';
import 'package:movies_app/mainLayout/data/models/movie_data_model.dart';

class HomeTabViewModel extends ChangeNotifier {
  List<MovieDataModel> availableMoviesList = [];
  List<MovieDataModel> genreMoviesList = [];
  String errorForAvialableMovies = '';
  String errorForGenreMovies = '';
  int categoryIndex = 0;

  void getAvailableMovies() async {
    var result = await ApiServices.getMovies(
      sortedBy: 'year',
    );
    result.fold(
      (left) {
        availableMoviesList = left;
        notifyListeners();
      },
      (right) {
        errorForAvialableMovies = right;
        notifyListeners();
      },
    );
  }

  void getMoviesBasedOnGenre({String genre = ''}) async {
    var result = await ApiServices.getMovies(genre: genre, limit: 30);
    result.fold(
      (left) {
        genreMoviesList = left;
        notifyListeners();
      },
      (right) {
        errorForGenreMovies = right;
        notifyListeners();
      },
    );
  }

  void incrementCategoryIndex() {
    categoryIndex++;
    if (categoryIndex > 19) {
      categoryIndex = 0;
    }
  }
}
