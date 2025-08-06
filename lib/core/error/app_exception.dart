import 'package:dio/dio.dart';

class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, {this.code});

  @override
  String toString() => 'AppException: $message';

  static AppException fromDioError(dynamic error) {
    if (error is! DioException) {
      return AppException("Unexpected error");
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return AppException("Connection timeout");
      case DioExceptionType.sendTimeout:
        return AppException("Send timeout");
      case DioExceptionType.receiveTimeout:
        return AppException("Receive timeout");
      case DioExceptionType.badResponse:
        return _handleBadResponse(error);
      case DioExceptionType.cancel:
        return AppException("Request cancelled");
      case DioExceptionType.unknown:
      default:
        return AppException("No internet or unknown error");
    }
  }

  static AppException _handleBadResponse(DioException error) {
    final response = error.response;

    if (response == null) {
      return AppException("No response from server");
    }

    try {
      final data = response.data;

      if (data is Map && data.containsKey("message")) {
        return AppException(data["message"].toString());
      }

      return AppException("Server error: ${response.statusCode}");
    } catch (_) {
      return AppException("Something went wrong");
    }
  }
}
