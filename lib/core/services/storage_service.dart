import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<SharedPreferences> get _preferences => SharedPreferences.getInstance();

  Future<bool> setString(String key, String value) async =>
      (await _preferences).setString(key, value);

  Future<String?> getString(String key) async =>
      (await _preferences).getString(key);

  Future<bool> remove(String key) async => (await _preferences).remove(key);

  Future<bool> clear() async => (await _preferences).clear();
}
