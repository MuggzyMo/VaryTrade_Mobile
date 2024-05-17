import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  const SecureStorage();

  Future storeEmail(String email) async {
    await storage.write(key: "email", value: email);
  }

  Future storeUserName(String userName) async {
    await storage.write(key: "userName", value: userName);
  }

  Future storeJwtToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  Future storePassword(String password) async {
    await storage.write(key: "password", value: password);
  }

  Future<String?> getEmail() async {
    return await storage.read(key: 'email');
  }

  Future<String?> getJwtToken() async {
    return await storage.read(key: "token");
  }

  Future<String?> getUserName() async {
    return await storage.read(key: "userName");
  }

  Future<String?> getPassword() async {
    return await storage.read(key: "password");
  }
}
