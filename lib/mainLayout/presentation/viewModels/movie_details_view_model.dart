import 'package:flutter/material.dart';
import 'package:movies_app/mainLayout/data/api_services.dart';
import 'package:movies_app/mainLayout/data/models/movie_data_model.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  bool isLoading = true;
  bool isMovieSuggestionsLoading = true;
  MovieDataModel? movie;
  String errorMessage = '';
  List<MovieDataModel> movieSuggestionsList = [];
  bool isMovieFavorite = false;

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

  Future<void> addMovieToFavorite(
      {required String token,
      required String movieId,
      required String name,
      required double rating,
      required String imageURL,
      required String year}) async {
    await ApiServices.addMovieToFavorite(
      token: token,
      movieId: movieId,
      name: name,
      rating: rating,
      imageURL: imageURL,
      year: year,
    );
  }

  Future<void> deleteMovieFromFavorite({
    required String token,
    required String movieId,
  }) async {
    await ApiServices.deleteMovieFromFavorite(
      token: token,
      movieId: movieId,
    );
  }

  Future<void> checkFavoriteMovies({
    required String token,
    required int movieId,
  }) async {
    final response = await ApiServices.checkFavoriteMovies(
      token: token,
      movieId: movieId,
    );
    if (response.data is bool) {
      isMovieFavorite = response.data;
      notifyListeners();
    } else {
      isMovieFavorite = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus({
    required String token,
  }) async {
    isMovieFavorite = !isMovieFavorite;
    notifyListeners();

    if (isMovieFavorite) {
      await addMovieToFavorite(
        token: token,
        movieId: '${movie!.id}',
        name: movie!.title,
        rating: movie?.rating ?? 0,
        imageURL: movie?.largeCoverImage ?? '',
        year: '${movie!.year}',
      );
    } else {
      await deleteMovieFromFavorite(
        token: token,
        movieId: movie!.id.toString(),
      );
    }
  }
}
