import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> saveString(String key, String string) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    await sharedPreferences.setString(key, string);
  }

  static Future<String?> getString(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }
}

class SecureStorageHelper {
  // Create storage instance
  static final _storage = FlutterSecureStorage(

  );

  /// Save a string value
  static Future<void> saveString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Read a string value
  static Future<String?> getString(String key) async {
    return await _storage.read(key: key);
  }

  /// Delete a value
  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Check if a key exists
  static Future<bool> containsKey(String key) async {
    return (await _storage.read(key: key)) != null;
  }

  /// Delete all stored values
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
