import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_tmdb/domain/api_client/api.dart';
import 'package:movie_tmdb/domain/dataProvider/sessionDataProvider.dart';
import 'package:movie_tmdb/domain/entity/movieDetails.dart';

class MovieDetailsModel extends ChangeNotifier {
  MovieDetails? _movieDetails;
  bool favorite = false;
  final sessionProvider = Sessiondataprovider();
  final _apiClient = api_client();
  final int movieId;
  Future<void>? Function()? onSessionExired;
  //  DateFormat _dateFormater;

  MovieDetails? get movieDetails => _movieDetails;

  String stringFromDate(DateTime date) =>
      date != null ? DateFormat().format(date) : "";

  MovieDetailsModel({required this.movieId});

  Future<void> loadDetails() async {
    _movieDetails = await _apiClient.movieDetails(movieId, "ua-UA");
    final sessionId = await sessionProvider.getSession();
    if (sessionId != null) {
      print(sessionId);
      favorite = await _apiClient.isFavorite(movieId, sessionId);
      // print(favorite);
    } else {
      print("session id error");
    }

    notifyListeners();
  }

  Future<void> setupLocale() async {
    await loadDetails();
  }

  Future<void> toggleFavorite() async {
    final sessionId = await sessionProvider.getSession();
    final accauntId = await sessionProvider.getAccountId();
    if (sessionId == null || accauntId == null) return;
    final newFavorite = !favorite;
    favorite = newFavorite;
    notifyListeners();
    try {
      await _apiClient.markAsFvourite(
          account_id: accauntId,
          session_id: sessionId,
          mediaType: ApiClientMediaType.Movie,
          media_id: movieId,
          isFavorite: newFavorite);
    } on ApiClientErrors catch (e) {
      switch (e.type) {
        case ApiClientExpeptionType.SessionExpired:
          await onSessionExired?.call();
          break;
        default:
      }
    } catch (e) {
      print(e);
    }
  }
}
