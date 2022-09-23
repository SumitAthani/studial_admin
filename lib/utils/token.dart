import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Token {
  static const storage = FlutterSecureStorage();

  static save(value) async {
    // not handled storage errors
    await storage.write(key: "token", value: value);
  }

  static get() async {
    var token = await storage.read(key: "token");
    return token;
  }

  static delete() async {
    await storage.deleteAll();
  }
}
