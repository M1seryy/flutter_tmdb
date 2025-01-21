import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

enum ApiClientExpeptionType {
  Network,
  Auth,
  Other;
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

  Future<String> _makeToken() async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap["request_token"] as String;
      return token;
    };

    final result = get('/authentication/token/new', parser,
        <String, dynamic>{"api_key": _API_KEY});
    return result;
  }

  Future<String> _validateUser({
    required login,
    required password,
    required user_token,
  }) async {
    try {
      final url = makeUri('/authentication/token/validate_with_login',
          <String, dynamic>{"api_key": _API_KEY});
      final params = <String, dynamic>{
        "username": login,
        "password": password,
        "request_token": user_token,
      };
      final request = await _client.postUrl(
        url,
      );
      request.headers.contentType = ContentType.json;
      request.headers.set('Authorization', 'Bearer $_API_KEY');
      request.write(jsonEncode(params));
      final responce = await request.close();
      final json = await responce.jsonDecode() as Map<String, dynamic>;
      validateStatusCode(responce, json);
      final token = json["request_token"];
      return token;
    } on SocketException {
      throw ApiClientErrors(ApiClientExpeptionType.Network);
    } on ApiClientErrors {
      rethrow;
    } catch (_) {
      throw ApiClientErrors(ApiClientExpeptionType.Other);
    }
  }

  void validateStatusCode(
      HttpClientResponse responce, Map<String, dynamic> json) {
    if (responce.statusCode == 401) {
      final status = json["status_code"];
      final code = status is int ? status : 0;
      if (code == 30) {
        throw ApiClientErrors(ApiClientExpeptionType.Auth);
      }
      throw ApiClientErrors(ApiClientExpeptionType.Other);
    }
  }

  Future<String> _makeSession({
    required user_token,
  }) async {
    try {
      final url = makeUri('/authentication/session/new',
          <String, dynamic>{"api_key": _API_KEY});

      final params = <String, dynamic>{
        "request_token": user_token,
      };
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.headers.set('Authorization', 'Bearer $_API_KEY');
      request.write(jsonEncode(params));
      final responce = await request.close();
      final json = await responce.jsonDecode() as Map<String, dynamic>;
      validateStatusCode(responce, json);
      final sessionId = json["session_id"];
      print('session $sessionId');
      return sessionId;
    } on SocketException {
      throw ApiClientErrors(ApiClientExpeptionType.Network);
    } on ApiClientErrors {
      rethrow;
    } catch (_) {
      throw ApiClientErrors(ApiClientExpeptionType.Other);
    }
  }
}

extension HttpClientResponceJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}
// https://api.themoviedb.org/3/authentication/token/new?api_key=eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZGZmZjI0OTJkYWI3NzkzZTQ4MTIwOTFjZmIzZTllMSIsIm5iZiI6MTY1NjY3NTIzOS41NTIsInN1YiI6IjYyYmVkYmE3MjJlNDgwMDQ5NzE5NDNmZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BCI4I9p0BV3tYVhzECcnIfaB2PZfb3wbrkvOPc2D-WI
// https://api.themoviedb.org/3/authentication/token/new?api_key=eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZGZmZjI0OTJkYWI3NzkzZTQ4MTIwOTFjZmIzZTllMSIsIm5iZiI6MTY1NjY3NTIzOS41NTIsInN1YiI6IjYyYmVkYmE3MjJlNDgwMDQ5NzE5NDNmZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BCI4I9p0BV3tYVhzECcnIfaB2PZfb3wbrkvOPc2D-WI
