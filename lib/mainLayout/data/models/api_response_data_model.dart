import 'package:movies_app/mainLayout/data/models/movie_data_model.dart';

class ApiResponseDataModel {
  final String status;
  final String statusMessage;
  final List<MovieDataModel> movies;

  ApiResponseDataModel({
    required this.status,
    required this.statusMessage,
    required this.movies,
  });

  factory ApiResponseDataModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseDataModel(
      status: json['status'] as String,
      statusMessage: json['status_message'] as String,
      movies: (json['data']['movies'] as List)
          .map((movie) => MovieDataModel.fromJson(movie as Map<String, dynamic>))
          .toList(),
    );
  }
}
