import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const tokenKey = 'token';

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<String> getToken() async {
    return storage.read(key: tokenKey);
  }

  Future<void> saveToken(String token) async {
    await storage.write(key: tokenKey, value: token);
  }

  Future<void> clear() async {
    await storage.delete(key: tokenKey);
  }
}
