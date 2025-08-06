import 'dart:convert';

import 'package:trade_for_you_app/common/app_keys.dart';
import 'package:trade_for_you_app/core/services/local_cache_service.dart';
import 'package:trade_for_you_app/features/auth/data/models/user_model.dart';

abstract class UserLocalDataSource {
  Future<void> saveUser(UserModel user);
  UserModel? getUser();
  Future<void> clearUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final LocalCacheService cache;

  UserLocalDataSourceImpl(this.cache);

  @override
  Future<void> saveUser(UserModel user) {
    final jsonString = jsonEncode(user.toJson());
    return cache.saveString(AppKeys.lsUserData, jsonString);
  }

  @override
  UserModel? getUser() {
    final jsonString = cache.getString(AppKeys.lsUserData);
    if (jsonString == null) return null;

    try {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return UserModel.fromJson(jsonMap);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> clearUser() => cache.remove(AppKeys.lsUserData);
}
