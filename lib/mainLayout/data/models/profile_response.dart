import 'package:movies_app/authentication/data/models/user_data_model.dart';
import 'package:movies_app/mainLayout/data/models/movie_data_model.dart';

class ProfileResponse {
  String message;
  String? error;
  int? statusCode;
  dynamic data;

  ProfileResponse({
    required this.message,
    this.error,
    this.statusCode,
    this.data,
  });
  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    dynamic rawData = json['data'];
    dynamic parsedData;
    if (rawData is Map<String, dynamic>) {
      parsedData = UserDataModel.fromJson(rawData);
    } else if (rawData is List) {
      parsedData =
          rawData.map((item) => MovieDataModel.fromJson(item)).toList();
    } else if (rawData is bool) {
      parsedData = rawData;
    }
    return ProfileResponse(
        message: json['message'] ?? '',
        data: parsedData,
        error: json['error'] ?? '',
        statusCode: json['statusCode'] ?? 0);
  }
}
