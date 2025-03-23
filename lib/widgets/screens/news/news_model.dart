import 'package:flutter/material.dart';
import 'package:movie_tmdb/domain/api_client/api.dart';
import 'package:movie_tmdb/domain/entity/movie.dart';
import 'package:movie_tmdb/domain/entity/popular.dart';

class NewsModel extends ChangeNotifier {
  NewsModel() {
    newsLoadPopular();
  }
  PopularMovieResponse? popularMovies;
  final _apiClient = api_client();

  Future<void> newsLoadPopular() async {
    popularMovies = await _apiClient.getPopular(1, "ua-UA");
    print(popularMovies?.movies.length);
    notifyListeners();
  }
}
