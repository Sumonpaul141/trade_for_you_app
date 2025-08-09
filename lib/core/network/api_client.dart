import 'package:trade_for_you_app/core/network/api_response.dart';

abstract class ApiClient {
  Future<ApiResponse<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) fromJsonT,
  });

  Future<ApiResponse<T>> post<T>(
    String url, {
    dynamic data,
    required T Function(dynamic) fromJsonT,
  });

  Future<ApiResponse<T>> patch<T>(
    String url, {
    dynamic data,
    required T Function(dynamic) fromJsonT,
  });

  Future<ApiResponse<T>> put<T>(
    String url, {
    dynamic data,
    required T Function(dynamic) fromJsonT,
  });

  Future<ApiResponse<T>> delete<T>(
    String url, {
    dynamic data,
    required T Function(dynamic) fromJsonT,
  });
}
