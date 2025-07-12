import 'package:movies_app/mainLayout/data/models/movie_data_model.dart';

class MovieDetailsResponse {
  final String status;
  final String statusMessage;
  final MovieDataModel movie;

 MovieDetailsResponse({
    required this.status,
    required this.statusMessage,
    required this.movie,
  });

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) {
    return MovieDetailsResponse(
      status: json['status'] as String,
      statusMessage: json['status_message'] as String,
      movie:MovieDataModel.fromJson(json['data']['movie'] as Map<String,dynamic>)
    );
  }
}
