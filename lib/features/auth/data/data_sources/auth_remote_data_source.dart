import 'package:trade_for_you_app/common/api_endpoints.dart';
import 'package:trade_for_you_app/core/error/app_exception.dart';
import 'package:trade_for_you_app/core/network/api_client.dart';
import 'package:trade_for_you_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<UserModel> login(String username, String password) async {
    final response = await _apiClient.post<UserModel>(
      ApiEndpoints.login,
      data: {'username': username, 'password': password},
      fromJsonT: (val) => UserModel.fromJson(val),
    );
    if (response.data != null) {
      return response.data!;
    }
    throw AppException("Invalid response: User data is missing");
  }
}
