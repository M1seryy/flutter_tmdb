import 'package:movie_tmdb/domain/dataProvider/sessionDataProvider.dart';

class MainModel {
  final _session = Sessiondataprovider();
  var _isAuth = false;

  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final sessionId = await _session.getSession();
    _isAuth = sessionId != null;
  }
}
