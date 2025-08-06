import 'package:dio/dio.dart';

abstract class ApiClient {
  Future<Response> get(String url, {Map<String, dynamic>? queryParameters});
  Future<Response> post(String url, {dynamic data});
  Future<Response> put(String url, {dynamic data});
  Future<Response> delete(String url, {dynamic data});
}
