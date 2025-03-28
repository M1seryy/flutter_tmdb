import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movie_tmdb/domain/entity/movie.dart';
import 'package:movie_tmdb/domain/entity/movieDetails.dart';
import 'package:movie_tmdb/domain/entity/popular.dart';

enum ApiClientMediaType { Movie, TV }

extension MediaTypeAsString on ApiClientMediaType {
  String asString() {
    switch (this) {
      case ApiClientMediaType.Movie:
        return "movie";
      case ApiClientMediaType.TV:
        return "tv";
    }
  }
}

enum ApiClientExpeptionType {
  Network,
  Auth,
  Other,
  SessionExpired;
}

class ApiClientErrors implements Exception {
  final ApiClientExpeptionType type;

  ApiClientErrors(this.type);
}

class api_client {
  final _client = HttpClient();

  static const _BASE_URL = "https://api.themoviedb.org/3";
  static const _API_KEY =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZGZmZjI0OTJkYWI3NzkzZTQ4MTIwOTFjZmIzZTllMSIsIm5iZiI6MTY1NjY3NTIzOS41NTIsInN1YiI6IjYyYmVkYmE3MjJlNDgwMDQ5NzE5NDNmZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BCI4I9p0BV3tYVhzECcnIfaB2PZfb3wbrkvOPc2D-WI";

  static const _IMAGE_URL = "https://image.tmdb.org/t/p/w500";

  static String posterUrl(String path) => _IMAGE_URL + path;

  Uri makeUri(String path, [Map<String, dynamic>? params]) {
    final uri = Uri.parse('$_BASE_URL$path');

    if (params != null) {
      return uri.replace(queryParameters: params);
    }
    return uri;
  }

  Future<String> auth({
    required login,
    required password,
  }) async {
    final token = await _makeToken();
    final isValidated = await _validateUser(
        login: login, password: password, user_token: token);
    final session = await _makeSession(user_token: token);
    return session;
  }

  Future<T> post<T>(String path, T Function(dynamic json) parser,
      Map<String, dynamic>? bodyParams,
      [Map<String, dynamic>? urlParams]) async {
    try {
      final url = makeUri(path, urlParams);
      final request = await _client.postUrl(
        url,
      );
      request.headers.contentType = ContentType.json;
      request.headers.set('Authorization', 'Bearer $_API_KEY');
      request.write(jsonEncode(bodyParams));
      final responce = await request.close();
      if (responce.statusCode == 201) {
        return 1 as T;
      }
      final json = (await responce.jsonDecode()) as dynamic;
      validateStatusCode(responce, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientErrors(ApiClientExpeptionType.Network);
    } on ApiClientErrors {
      rethrow;
    } catch (_) {
      throw ApiClientErrors(ApiClientExpeptionType.Other);
    }
  }

  Future<T> get<T>(String path, T Function(dynamic json) parser,
      [Map<String, dynamic>? params]) async {
    final url = makeUri(path, params);
    try {
      final request = await _client.getUrl(url);
      request.headers.set('Authorization', 'Bearer $_API_KEY');
      final responce = await request.close();
      final json = await responce.jsonDecode();
      validateStatusCode(responce, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientErrors(ApiClientExpeptionType.Network);
    } on ApiClientErrors {
      rethrow;
    } catch (_) {
      throw ApiClientErrors(ApiClientExpeptionType.Other);
    }
  }

  Future<int> getAccoutData(String sessionId) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap["id"] as int;
      // final responce = MovieDetails.fromJson(jsonMap);
      return result;
    }

    final result = get('/account', parser,
        <String, dynamic>{"api_key": _API_KEY, "session_id": sessionId});
    return result;
  }

  Future<String> _makeToken() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap["request_token"] as String;
      return token;
    }

    final result = get('/authentication/token/new', parser,
        <String, dynamic>{"api_key": _API_KEY});
    return result;
  }

  Future<int> markAsFvourite({
    required int account_id,
    required String session_id,
    required ApiClientMediaType mediaType,
    required int media_id,
    required bool isFavorite,
  }) async {
    parser(dynamic json) {
      return 1;
    }

    final bodyParams = <String, dynamic>{
      "media_type": mediaType.asString(),
      "media_id": media_id.toString(),
      "favorite": isFavorite.toString(),
    };

    final result = post('/account/{$account_id}/favorite', parser, bodyParams,
        <String, dynamic>{"api_key": _API_KEY, "session_id": session_id});
    return result;
  }

  Future<String> _validateUser({
    required login,
    required password,
    required user_token,
  }) async {
    final bodyParams = <String, dynamic>{
      "username": login,
      "password": password,
      "request_token": user_token,
    };
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap["request_token"] as String;
      return token;
    }

    final result = post('/authentication/token/validate_with_login', parser,
        bodyParams, <String, dynamic>{"api_key": _API_KEY});
    return result;
  }

  void validateStatusCode(
      HttpClientResponse responce, Map<String, dynamic> json) {
    if (responce.statusCode == 401) {
      final status = json["status_code"];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientErrors(ApiClientExpeptionType.Auth);
      } else if (code == 3) {
        throw ApiClientErrors(ApiClientExpeptionType.SessionExpired);
      }
      throw ApiClientErrors(ApiClientExpeptionType.Other);
    }
  }

  Future<String> _makeSession({
    required user_token,
  }) async {
    final bodyParams = <String, dynamic>{
      "request_token": user_token,
    };

    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap["session_id"] as String;
      return sessionId;
    }

    final result = post('/authentication/session/new', parser, bodyParams,
        <String, dynamic>{"api_key": _API_KEY});
    return result;
  }

  Future<PopularMovieResponse> getPopular(int page, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final responce = PopularMovieResponse.fromJson(jsonMap);
      return responce;
    }

    final result = get('/movie/popular', parser, <String, dynamic>{
      "api_key": _API_KEY,
      "page": "$page",
      "language": "uk-UA"
    });
    return result;
  }

  Future<bool> isFavorite(
    int movieId,
    String sessionId,
  ) async {
    print("isFavorite $sessionId");
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['favorite'] as bool;
      return result;
    };
    final result = get(
      '/movie/$movieId/account_states',
      parser,
      <String, dynamic>{
        'api_key': _API_KEY,
        'session_id': sessionId,
      },
    );
    return result;
  }

  Future<MovieDetails> movieDetails(int id, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final responce = MovieDetails.fromJson(jsonMap);
      return responce;
    }

    final result = get('/movie/$id', parser, <String, dynamic>{
      "api_key": _API_KEY,
      "language": "uk-UA",
      "append_to_response": "credits,videos"
    });
    return result;
  }

  Future<PopularMovieResponse> searchMovies(
      int page, String locale, String query) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final responce = PopularMovieResponse.fromJson(jsonMap);
      return responce;
    }

    final result = get('/search/movie', parser, <String, dynamic>{
      "api_key": _API_KEY,
      "page": "$page",
      "language": "uk-UA",
      'query': query,
      "include_adult": true.toString(),
    });
    return result;
  }

  Future<void> popularMovies() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final responce = Movie.fromJson(jsonMap);
      print(responce);
      return responce;
    }

    final result = get('/movie/popular', parser, <String, dynamic>{
      "api_key": _API_KEY,
      "language": "uk-UA",
      "append_to_response": "credits,videos",
      "include_video": true,
    });
    // return result;
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    final responseBody = await transform(utf8.decoder).join();
    // print("Raw response: $responseBody"); // Друкуємо, що саме приходить

    if (responseBody.isEmpty) {
      throw Exception("Empty response body");
    }

    try {
      return json.decode(responseBody);
    } catch (e) {
      print("JSON Decode Error: $e");
      throw Exception("Invalid JSON response");
    }
  }
}

// https://api.themoviedb.org/3/authentication/token/new?api_key=eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZGZmZjI0OTJkYWI3NzkzZTQ4MTIwOTFjZmIzZTllMSIsIm5iZiI6MTY1NjY3NTIzOS41NTIsInN1YiI6IjYyYmVkYmE3MjJlNDgwMDQ5NzE5NDNmZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BCI4I9p0BV3tYVhzECcnIfaB2PZfb3wbrkvOPc2D-WI
// https://api.themoviedb.org/3/authentication/token/new?api_key=eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZGZmZjI0OTJkYWI3NzkzZTQ4MTIwOTFjZmIzZTllMSIsIm5iZiI6MTY1NjY3NTIzOS41NTIsInN1YiI6IjYyYmVkYmE3MjJlNDgwMDQ5NzE5NDNmZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BCI4I9p0BV3tYVhzECcnIfaB2PZfb3wbrkvOPc2D-WI
