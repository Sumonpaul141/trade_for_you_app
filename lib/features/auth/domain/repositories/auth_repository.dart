import 'package:trade_for_you_app/core/error/app_exception.dart';
import 'package:trade_for_you_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:trade_for_you_app/features/auth/data/data_sources/user_local_data_source.dart';
import 'package:trade_for_you_app/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login(String username, String password);
  Future<void> logout();
  UserModel? getLoggedInUser();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource, this._userLocalDataSource);

  @override
  Future<UserModel> login(String username, String password) async {
    final user = await _authRemoteDataSource.login(username, password);
    if (user.role == "admin") {
      await _userLocalDataSource.saveUser(user);
      return user;
    } else {
      throw AppException("Only admin can login");
    }
  }

  @override
  Future<void> logout() async {
    await _userLocalDataSource.clearUser();
  }

  @override
  UserModel? getLoggedInUser() {
    return _userLocalDataSource.getUser();
  }
}
