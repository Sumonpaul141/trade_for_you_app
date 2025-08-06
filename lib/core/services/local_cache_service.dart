abstract class LocalCacheService {
  Future<void> saveString(String key, String value);
  Future<void> saveBool(String key, bool value);
  Future<void> saveInt(String key, int value);
  Future<void> saveDouble(String key, double value);
  Future<void> saveStringList(String key, List<String> value);

  String? getString(String key);
  bool? getBool(String key);
  int? getInt(String key);
  double? getDouble(String key);
  List<String>? getStringList(String key);

  Future<bool> contains(String key);
  Future<void> remove(String key);
  Future<void> clear();
}
