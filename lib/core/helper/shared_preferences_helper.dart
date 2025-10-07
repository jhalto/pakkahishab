import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> saveString(String key, String string) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

   await sharedPreferences.setString(key, string);
  }

  static Future<String?> getString(String key) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }
}
