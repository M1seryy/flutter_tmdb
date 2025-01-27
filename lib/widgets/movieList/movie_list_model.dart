import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_tmdb/domain/api_client/api.dart';
import 'package:movie_tmdb/domain/entity/movie.dart';
import 'package:movie_tmdb/widgets/navigation/mainNavigation.dart';

class MovieListModel extends ChangeNotifier {
  final _client = api_client();
  final _movieList = <Movie>[];
  List<Movie> get movieList => _movieList;

  String dateTimeParser(DateTime date) => DateFormat.yMMMd().format(date);

  Future<void> loadMovies() async {
    final movies = await _client.getPopular(1, "ua-UA");
    _movieList.addAll(movies.movies);
    notifyListeners();
  }

  void onMovieTap(BuildContext context, int index) async {
    final id = _movieList[index].id;
    Navigator.of(context).pushNamed(MainNavRoutes.movieDetails, arguments: id);
  }
}

class movie_list_provider extends InheritedNotifier {
  final Widget child;
  final MovieListModel model;
  const movie_list_provider(
      {super.key, required this.child, required this.model})
      : super(child: child, notifier: model);

  static movie_list_provider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<movie_list_provider>();
  }

  static movie_list_provider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<movie_list_provider>()
        ?.widget;
    return widget is movie_list_provider ? widget : null;
  }
}
