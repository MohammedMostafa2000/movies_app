import 'package:movies_app/mainLayout/data/models/cast_data_model.dart';

class MovieDataModel {
  final int id;
  final String url;
  final String imdbCode;
  final String title;
  final String titleEnglish;
  final String titleLong;
  final String slug;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final int likeCount;
  final String descriptionIntro;
  final String descriptionFull;
  final String ytTrailerCode;
  final String language;
  final String mpaRating;
  final String backgroundImage;
  final String backgroundImageOriginal;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;
  final String mediumScreenshotImage1;
  final String mediumScreenshotImage2;
  final String mediumScreenshotImage3;
  final String largeScreenshotImage1;
  final String largeScreenshotImage2;
  final String largeScreenshotImage3;
  final List<CastDataModel> cast;
  final String dateUploaded;
  final int dateUploadedUnix;

  const MovieDataModel({
    required this.id,
    required this.url,
    required this.imdbCode,
    required this.title,
    required this.titleEnglish,
    required this.titleLong,
    required this.slug,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.likeCount,
    required this.descriptionIntro,
    required this.descriptionFull,
    required this.ytTrailerCode,
    required this.language,
    required this.mpaRating,
    required this.backgroundImage,
    required this.backgroundImageOriginal,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.mediumScreenshotImage1,
    required this.mediumScreenshotImage2,
    required this.mediumScreenshotImage3,
    required this.largeScreenshotImage1,
    required this.largeScreenshotImage2,
    required this.largeScreenshotImage3,
    required this.cast,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  factory MovieDataModel.fromJson(Map<String, dynamic> json) {
    return MovieDataModel(
      id: json['id'] ?? (json['movieId'] != null ? int.tryParse(json['movieId']) : null) ?? 0,
      url: json['url'] ?? '',
      imdbCode: json['imdb_code'] ?? '',
      title: json['title'] ?? '',
      titleEnglish: json['title_english'] ?? '',
      titleLong: json['title_long'] ?? '',
      slug: json['slug'] ?? '',
      year: json['year'] is int ? json['year'] : int.tryParse(json['year']?.toString() ?? '') ?? 0,
      rating: json['rating'] is num
          ? (json['rating'] as num).toDouble()
          : double.tryParse(json['rating']?.toString() ?? '') ?? 0.0,
      runtime: json['runtime'] is int
          ? json['runtime']
          : int.tryParse(json['runtime']?.toString() ?? '') ?? 0,
      genres: (json['genres'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      likeCount: json['like_count'] ?? 0,
      descriptionIntro: json['description_intro'] ?? '',
      descriptionFull: json['description_full'] ?? '',
      ytTrailerCode: json['yt_trailer_code'] ?? '',
      language: json['language'] ?? '',
      mpaRating: json['mpa_rating'] ?? '',
      backgroundImage: json['background_image'] ?? '',
      backgroundImageOriginal: json['background_image_original'] ?? '',
      smallCoverImage: json['small_cover_image'] ?? '',
      mediumCoverImage: json['medium_cover_image'] ?? '',
      largeCoverImage: json['large_cover_image'] ?? json['imageURL'] ?? '',
      mediumScreenshotImage1: json['medium_screenshot_image1'] ?? '',
      mediumScreenshotImage2: json['medium_screenshot_image2'] ?? '',
      mediumScreenshotImage3: json['medium_screenshot_image3'] ?? '',
      largeScreenshotImage1: json['large_screenshot_image1'] ?? '',
      largeScreenshotImage2: json['large_screenshot_image2'] ?? '',
      largeScreenshotImage3: json['large_screenshot_image3'] ?? '',
      cast: (json['cast'] as List<dynamic>?)
              ?.map((element) => CastDataModel.fromJson(element))
              .toList() ??
          [],
      dateUploaded: json['date_uploaded'] ?? '',
      dateUploadedUnix: json['date_uploaded_unix'] ?? 0,
    );
  }
}
