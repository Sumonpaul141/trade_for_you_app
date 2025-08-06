import 'package:dio/dio.dart';
import 'package:trade_for_you_app/core/error/app_exception.dart';

import 'api_client.dart';

class DioClient implements ApiClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }

  @override
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(url, queryParameters: queryParameters);
    } catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<Response> post(String url, {data}) async {
    try {
      return await _dio.post(url, data: data);
    } catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<Response> put(String url, {data}) async {
    try {
      return await _dio.put(url, data: data);
    } catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  @override
  Future<Response> delete(String url, {data}) async {
    try {
      return await _dio.delete(url, data: data);
    } catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
