import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/mainLayout/data/models/movie_response_data_model.dart';
import 'package:movies_app/mainLayout/data/models/movie_data_model.dart';
import 'package:movies_app/mainLayout/data/models/movie_details_response.dart';
import 'package:movies_app/mainLayout/data/models/profile_response.dart';

class ApiServices {
  static Future<Either<List<MovieDataModel>, String>> getMovies(
      {String genre = '',
      int limit = 10,
      String sortedBy = '',
      String query = '',
      int page = 1}) async {
    try {
      final url = Uri.parse(
          'https://yts.mx/api/v2/list_movies.json?genre=$genre&limit=$limit&page=$page&sort_by=$sortedBy&query_term=$query');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final movieResponse = MovieResponseDataModel.fromJson(json);
        return left(movieResponse.movies);
      } else {
        return right('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  static Future<Either<MovieDataModel, String>> getMovieDetails(
      {int movieId = 0}) async {
    try {
      final url = Uri.parse(
          'https://yts.mx/api/v2/movie_details.json?movie_id=$movieId&with_images=true&with_cast=true');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final movieResponse = MovieDetailsResponse.fromJson(json);
        return left(movieResponse.movie);
      } else {
        return right('Request failed with status: ${response.statusCode}');
      }
    } on Exception catch (e) {
      return right(e.toString());
    }
  }

  static Future<Either<List<MovieDataModel>, String>> getMovieSuggestions(
      {int movieId = 0}) async {
    try {
      final url = Uri.parse(
          'https://yts.mx/api/v2/movie_suggestions.json?movie_id=$movieId');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final movieResponse = MovieResponseDataModel.fromJson(json);
        return left(movieResponse.movies);
      } else {
        return right('Request failed with status: ${response.statusCode}');
      }
    } on Exception catch (e) {
      return right(e.toString());
    }
  }

  static Future<ProfileResponse> getProfileDetails(
      {required String token}) async {
    try {
      Uri url = Uri.parse('https://route-movie-apis.vercel.app/profile');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      final json = jsonDecode(response.body);
      return ProfileResponse.fromJson(json);
    } on Exception catch (exception) {
      return ProfileResponse(message: exception.toString());
    }
  }

  static Future<ProfileResponse> addMovieToFavorite({
    required String token,
    required String movieId,
    required String name,
    required double rating,
    required String imageURL,
    required String year,
  }) async {
    try {
      Uri url = Uri.parse('https://route-movie-apis.vercel.app/favorites/add');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "movieId": movieId,
          "name": name,
          "rating": rating,
          "imageURL": imageURL,
          "year": year,
        }),
      );
      final json = jsonDecode(response.body);
      return ProfileResponse.fromJson(json);
    } on Exception catch (exception) {
      return ProfileResponse(message: exception.toString());
    }
  }

  static Future<ProfileResponse> deleteMovieFromFavorite({
    required String token,
    required String movieId,
  }) async {
    try {
      Uri url = Uri.parse(
          'https://route-movie-apis.vercel.app/favorites/remove/$movieId');
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final json = jsonDecode(response.body);
      return ProfileResponse.fromJson(json);
    } on Exception catch (exception) {
      return ProfileResponse(message: exception.toString());
    }
  }

  static Future<ProfileResponse> getAllFavoriteMovies(
      {required String token}) async {
    try {
      Uri url = Uri.parse('https://route-movie-apis.vercel.app/favorites/all');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final json = jsonDecode(response.body);
      return ProfileResponse.fromJson(json);
    } on Exception catch (exception) {
      return ProfileResponse(message: exception.toString());
    }
  }

  static Future<ProfileResponse> checkFavoriteMovies({
    required String token,
    required int movieId,
  }) async {
    try {
      Uri url = Uri.parse(
          'https://route-movie-apis.vercel.app/favorites/is-favorite/$movieId');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final json = jsonDecode(response.body);
      return ProfileResponse.fromJson(json);
    } on Exception catch (exception) {
      return ProfileResponse(message: exception.toString());
    }
  }
}
