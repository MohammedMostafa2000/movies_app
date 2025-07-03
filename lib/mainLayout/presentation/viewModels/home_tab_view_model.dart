import 'package:flutter/material.dart';
import 'package:movies_app/mainLayout/data/api_services.dart';
import 'package:movies_app/mainLayout/data/models/movie_data_model.dart';

class HomeTabViewModel extends ChangeNotifier {
  List<MovieDataModel> availableMoviesList = [];
  List<MovieDataModel> genreMoviesList = [];
  String errorForAvialableMovies = '';
  String errorForGenreMovies = '';
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

  void getActionMovies() async {
    var result = await ApiServices.getMovies(genre: 'action', limit: 50);
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
}
