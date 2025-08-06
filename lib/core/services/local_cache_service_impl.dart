// lib/core/services/local_cache_service_impl.dart

import 'package:shared_preferences/shared_preferences.dart';

import 'local_cache_service.dart';

class LocalCacheServiceImpl implements LocalCacheService {
  final SharedPreferences _prefs;

  LocalCacheServiceImpl(this._prefs);

  @override
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  @override
  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  @override
  Future<void> saveDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  @override
  Future<void> saveStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  @override
  String? getString(String key) => _prefs.getString(key);

  @override
  bool? getBool(String key) => _prefs.getBool(key);

  @override
  int? getInt(String key) => _prefs.getInt(key);

  @override
  double? getDouble(String key) => _prefs.getDouble(key);

  @override
  List<String>? getStringList(String key) => _prefs.getStringList(key);

  @override
  Future<bool> contains(String key) async => _prefs.containsKey(key);

  @override
  Future<void> remove(String key) async => _prefs.remove(key);

  @override
  Future<void> clear() async => _prefs.clear();
}
