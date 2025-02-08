import 'package:flutter/foundation.dart';
import 'package:movie_tmdb/domain/api_client/api.dart';
import 'package:movie_tmdb/domain/entity/movieDetails.dart';

class MovieDetailsModel extends ChangeNotifier {
  MovieDetails? _movieDetails;
  final _apiClient = api_client();
  final int movieId;

  MovieDetails? get movieDetails => _movieDetails;

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
