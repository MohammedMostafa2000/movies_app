class CastDataModel {
  final String name;
  final String characterName;
  final String urlSmallImage;
  final String imdbCode;

  CastDataModel({
    required this.name,
    required this.characterName,
    required this.urlSmallImage,
    required this.imdbCode,
  });

  factory CastDataModel.fromJson(Map<String, dynamic> json) {
    return CastDataModel(
      name: json['name']??'',
      characterName: json['character_name']??'',
      urlSmallImage: json['url_small_image']??'',
      imdbCode: json['imdb_code']??'',
    );
  }
}
