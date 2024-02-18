import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String getString(String key, {String defaultValue = ''}) {
    return _preferences.getString(key) ?? defaultValue;
  }

  static Future<bool> remove(String key) {
    return _preferences.remove(key);
  }

  static Future<bool> setString(String key, String value) {
    return _preferences.setString(key, value);
  }
}
