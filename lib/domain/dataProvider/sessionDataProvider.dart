import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _storageKeys {
  static const sessionKey = "session-id";
}

class Sessiondataprovider {
  static const storage = FlutterSecureStorage();
  Future<String?> getSession() => storage.read(key: _storageKeys.sessionKey);
  Future<void> setSession(String? value) {
    if (value != null) {
      return storage.write(key: _storageKeys.sessionKey, value: value);
    }
    return storage.delete(key: _storageKeys.sessionKey);
  }
}
