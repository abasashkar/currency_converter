import 'package:currency_app/models/api_response.dart';
import 'package:currency_app/utils/exceptions/app_exceptions.dart';
import 'package:dio/dio.dart';
abstract final class NetworkResponseHandler {
  static ApiResponse<T> handleSuccess<T>(
    Response<dynamic> response,
    T Function(dynamic json) parser,
  ) {
    final statusCode = response.statusCode ?? 0;
    if (statusCode < 200 || statusCode >= 300) {
      return ApiResponse.failure(
        message: 'Request failed with status $statusCode',
        statusCode: statusCode,
      );
    }
    try {
      final data = parser(response.data);
      return ApiResponse(data: data, statusCode: statusCode);
    } catch (e) {
      throw ParseException('Failed to parse response: $e');
    }
  }
  static Never throwFromDio(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const NetworkException(
          'Connection timed out. Please check your network.',
          code: 'timeout',
        );
      case DioExceptionType.connectionError:
        throw const NetworkException(
          'No internet connection. Please try again.',
          code: 'connection_error',
        );
      case DioExceptionType.badResponse:
        final status = error.response?.statusCode;
        throw NetworkException(
          'Server error${status != null ? ' ($status)' : ''}',
          code: 'bad_response',
        );
      case DioExceptionType.cancel:
        throw const NetworkException('Request was cancelled', code: 'cancel');
      default:
        throw NetworkException(
          error.message ?? 'An unexpected network error occurred',
          code: 'unknown',
        );
    }
  }
}
