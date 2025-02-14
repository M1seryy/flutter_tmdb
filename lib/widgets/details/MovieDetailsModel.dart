import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:movie_tmdb/domain/api_client/api.dart';
import 'package:movie_tmdb/domain/entity/movieDetails.dart';

class MovieDetailsModel extends ChangeNotifier {
  MovieDetails? _movieDetails;
  final _apiClient = api_client();
  final int movieId;
  //  DateFormat _dateFormater;

  MovieDetails? get movieDetails => _movieDetails;

  String stringFromDate(DateTime date) =>
      date != null ? DateFormat().format(date) : "";

  MovieDetailsModel({required this.movieId});

  Future<void> loadDetails() async {
    _movieDetails = await _apiClient.movieDetails(movieId, "ua-UA");
    notifyListeners();
  }

  Future<void> setupLocale() async {
    print("locate movie details");
    await loadDetails();
  }
}
