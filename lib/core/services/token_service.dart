import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static final instance = TokenService();
  late final FlutterSecureStorage storage;

  TokenService() {
    storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  Future<void> setToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
  }
}
