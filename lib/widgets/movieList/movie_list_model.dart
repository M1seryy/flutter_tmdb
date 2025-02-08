import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_tmdb/domain/api_client/api.dart';
import 'package:movie_tmdb/domain/entity/movie.dart';
import 'package:movie_tmdb/domain/entity/popular.dart';
import 'package:movie_tmdb/widgets/navigation/mainNavigation.dart';

class MovieListModel extends ChangeNotifier {
  final _client = api_client();
  late int _currentPage;
  late int totalPage;
  var isLoading = false;
  final _movieList = <Movie>[];
  List<Movie> get movieList => _movieList;
  late DateFormat _dateFormater;
  String _locale = "ua-UA";
  String? _searchQuery;
  Timer? searchDebounce;

  String dateTimeParser(DateTime date) => DateFormat.yMMMd().format(date);

  Future<void> setupLocale(BuildContext context) async {
    print("locale main list");
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (locale == _locale) return;
    _dateFormater = DateFormat.MMMMd(locale);
    _locale = locale;
    await resetList();
  }

  Future<PopularMovieResponse> loadMovies(int nextPage, String locale) async {
    final query = _searchQuery;
    if (query == null) {
      return await _client.getPopular(nextPage, _locale);
    }
    return await _client.searchMovies(nextPage, _locale, query);
  }

  Future<void> loadNextPage() async {
    if (isLoading || _currentPage >= totalPage) return;
    isLoading = true;
    final nextPage = _currentPage + 1;
    try {
      final movies = await loadMovies(nextPage, _locale);
      _currentPage = movies.page;
      totalPage = movies.totalPages;
      _movieList.addAll(movies.movies);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
    }
  }

  void onMovieTap(BuildContext context, int index) async {
    final id = _movieList[index].id;
    Navigator.of(context).pushNamed(MainNavRoutes.movieDetails, arguments: id);
  }

  void showNextMoviePage(int index) {
    if (index < movieList.length - 1) return;
    loadNextPage();
  }

  Future<void> resetList() async {
    _currentPage = 0;
    totalPage = 1;
    _movieList.clear();
    loadNextPage();
  }

  Future<void> searchMovieHandler(String text) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(seconds: 1), () async {
      final searchQuery = text.isNotEmpty ? text : null;
      if (_searchQuery == searchQuery) return;

      _searchQuery = searchQuery;
      await resetList();
    });
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
