import 'package:flutter/material.dart';
import 'package:movies_app/mainLayout/data/api_services.dart';
import 'package:movies_app/mainLayout/data/models/movie_data_model.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  bool isLoading = true;
  bool isMovieSuggestionsLoading = true;
  MovieDataModel? movie;
  String errorMessage = '';
  List<MovieDataModel> movieSuggestionsList = [];

  void getMovieDetails({int movieId = 0}) async {
    isLoading = true;
    var result = await ApiServices.getMovieDetails(movieId: movieId);

    result.fold(
      (left) {
        movie = left;
        isLoading = false;
        notifyListeners();
      },
      (right) {
        errorMessage = right;
        isLoading = false;
        notifyListeners();
      },
    );
  }

  void getMovieSuggestions({int movieId = 0}) async {
    isMovieSuggestionsLoading = true;
    var result = await ApiServices.getMovieSuggestions(movieId: movieId);
    result.fold(
      (left) {
        movieSuggestionsList = left;
        isMovieSuggestionsLoading = false;
        notifyListeners();
      },
      (right) {
        errorMessage = right;
        isMovieSuggestionsLoading = false;
        notifyListeners();
      },
    );
  }
}
