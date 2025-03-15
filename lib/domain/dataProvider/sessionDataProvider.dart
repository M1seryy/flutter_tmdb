import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _storageKeys {
  static const sessionKey = "session-id";
  static const accountKey = "account-id";
}

class Sessiondataprovider {
  static const storage = FlutterSecureStorage();
  Future<String?> getSession() => storage.read(key: _storageKeys.sessionKey);
  Future<void> setSession(String? value) {
    print("write session-id ,,,$value");
    if (value != null) {
      return storage.write(key: _storageKeys.sessionKey, value: value);
    }
    return storage.delete(key: _storageKeys.sessionKey);
  }

  Future<int?> getAccountId() async {
    final id = await storage.read(key: _storageKeys.accountKey);
    return id != null ? int.tryParse(id) : null;
  }

  Future<void> setAccountId(int? value) {
    if (value != null) {
      return storage.write(
          key: _storageKeys.accountKey, value: value.toString());
    }
    return storage.delete(key: _storageKeys.accountKey);
  }
}
