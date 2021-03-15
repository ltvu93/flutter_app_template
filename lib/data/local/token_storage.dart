import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const tokenKey = 'token';

  final _storage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    return _storage.read(key: tokenKey);
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: tokenKey, value: token);
  }

  Future<void> clear() async {
    await _storage.delete(key: tokenKey);
  }
}
