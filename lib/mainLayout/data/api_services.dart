import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/mainLayout/data/models/movie_response_data_model.dart';
import 'package:movies_app/mainLayout/data/models/movie_data_model.dart';
import 'package:movies_app/mainLayout/data/models/movie_details_response.dart';

class ApiServices {
  static Future<Either<List<MovieDataModel>, String>> getMovies(
      {String genre = '', int limit = 10, String sortedBy = '', String query = ''}) async {
    try {
      final url = Uri.parse(
          'https://yts.mx/api/v2/list_movies.json?genre=$genre&limit=$limit&sort_by=$sortedBy&query_term=$query');
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

  static Future<Either<MovieDataModel, String>> getMovieDetails({int movieId = 0}) async {
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

  static Future<Either<List<MovieDataModel>, String>> getMovieSuggestions({int movieId = 0}) async {
    try {
      final url = Uri.parse('https://yts.mx/api/v2/movie_suggestions.json?movie_id=$movieId');
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
}
