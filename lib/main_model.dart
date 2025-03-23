import 'package:flutter/material.dart';
import 'package:movie_tmdb/domain/dataProvider/sessionDataProvider.dart';
import 'package:movie_tmdb/widgets/navigation/mainNavigation.dart';

class MainModel {
  final _session = Sessiondataprovider();
  var _isAuth = false;

  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _session.getSession();
    _isAuth = sessionId != null;
  }

  Future<void> resetSession(BuildContext context) async {
    await _session.setSession(null);
    await _session.setAccountId(null);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(MainNavRoutes.auth, (route) => false);
  }
}
