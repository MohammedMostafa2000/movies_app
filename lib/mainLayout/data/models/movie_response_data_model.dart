import 'package:movies_app/mainLayout/data/models/movie_data_model.dart';

class MovieResponseDataModel {
  final String status;
  final String statusMessage;
  final List<MovieDataModel> movies;

  MovieResponseDataModel({
    required this.status,
    required this.statusMessage,
    required this.movies,
  });

  factory MovieResponseDataModel.fromJson(Map<String, dynamic> json) {
    return MovieResponseDataModel(
      status: json['status'] as String,
      statusMessage: json['status_message'] as String,
      movies: (json['data']['movies'] as List)
          .map((movie) => MovieDataModel.fromJson(movie as Map<String, dynamic>))
          .toList(),
    );
  }
}
