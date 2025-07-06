import 'package:flutter/material.dart';
import 'package:movies_app/mainLayout/data/api_services.dart';
import 'package:movies_app/mainLayout/data/models/movie_data_model.dart';

class BrowseTabViewModel extends ChangeNotifier {
  List<MovieDataModel> genreMoviesList = [];
  String errorForGenreMovies = '';
  bool isLoading = true;

  void getMoviesBasedOnGenre({String genre = ''}) async {
    isLoading = true;
    var result = await ApiServices.getMovies(genre: genre, limit: 20);
    result.fold(
      (left) {
        genreMoviesList = left;
        isLoading = false;
        notifyListeners();
      },
      (right) {
        errorForGenreMovies = right;
        isLoading = false;
        notifyListeners();
      },
    );
  }
}
