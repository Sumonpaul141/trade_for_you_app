import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_for_you_app/common/app_keys.dart';
import 'package:trade_for_you_app/core/error/app_exception.dart';
import 'package:trade_for_you_app/core/network/api_response.dart';
import 'package:trade_for_you_app/features/auth/data/models/user_model.dart';

import 'api_client.dart';

class DioClient implements ApiClient {
  final Dio _dio;
  final SharedPreferences _preferences;

  DioClient(this._dio, this._preferences) {
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final userData = _preferences.getString(AppKeys.lsUserData);
          if (userData != null) {
            var user = UserModel.fromJson(jsonDecode(userData));
            if (user.token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer ${user.token}';
            }
          }

          return handler.next(options);
        },
      ),
    );
  }

  @override
  Future<ApiResponse<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) fromJsonT,
  }) async {
    try {
      final res = await _dio.get(url, queryParameters: queryParameters);
      return ApiResponse<T>.fromJson(res.data, fromJsonT);
    } catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<T>> post<T>(
    String url, {
    dynamic data,
    required T Function(dynamic) fromJsonT,
  }) async {
    try {
      final res = await _dio.post(url, data: data);
      return ApiResponse<T>.fromJson(res.data, fromJsonT);
    } catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<T>> put<T>(
    String url, {
    dynamic data,
    required T Function(dynamic) fromJsonT,
  }) async {
    try {
      final res = await _dio.put(url, data: data);
      return ApiResponse<T>.fromJson(res.data, fromJsonT);
    } catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<T>> delete<T>(
    String url, {
    dynamic data,
    required T Function(dynamic) fromJsonT,
  }) async {
    try {
      final res = await _dio.delete(url, data: data);
      return ApiResponse<T>.fromJson(res.data, fromJsonT);
    } catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<ApiResponse<T>> patch<T>(
    String url, {
    dynamic data,
    required T Function(dynamic) fromJsonT,
  }) async {
    try {
      final res = await _dio.patch(url, data: data);
      return ApiResponse<T>.fromJson(res.data, fromJsonT);
    } catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
