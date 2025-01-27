import 'package:json_annotation/json_annotation.dart';
part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final String? poster_path;
  final bool adult;
  final String overview;
  @JsonKey(fromJson: _parseDateFromString)
  final DateTime? release_date;
  final List<int>? genre_ids; // зроблено nullable
  final int id;
  final String? original_title;
  final String original_language;
  final String title;
  final String? backdrop_path;
  final double popularity;
  final int vote_count;
  final bool video;
  final double vote_average;

  Movie({
    this.poster_path,
    required this.adult,
    required this.overview,
    this.release_date,
    this.genre_ids,
    required this.id,
    this.original_title,
    required this.original_language,
    required this.title,
    this.backdrop_path,
    required this.popularity,
    required this.vote_count,
    required this.video,
    required this.vote_average,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  /// Connect the generated [_$MovieToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  static DateTime? _parseDateFromString(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return null;
    return DateTime.tryParse(rawDate);
  }
}
