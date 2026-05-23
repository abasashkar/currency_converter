import 'package:currency_app/common/constants/api_constants.dart';
import 'package:currency_app/common/services/network_response_handler.dart';
import 'package:currency_app/models/api_response.dart';
import 'package:currency_app/utils/exceptions/app_exceptions.dart';
import 'package:dio/dio.dart';
class ApiClient {
  ApiClient(this._dio);
  final Dio _dio;
  bool _usingFallback = false;
  bool get isUsingFallback => _usingFallback;
  String get _baseUrl =>
      _usingFallback ? ApiConstants.fallbackBaseUrl : ApiConstants.primaryBaseUrl;
  Future<ApiResponse<T>> get<T>({
    required String path,
    required T Function(dynamic json) parser,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool allowFallback = true,
  }) async {
    try {
      return await _performGet(
        path: path,
        parser: parser,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } on DioException catch (error) {
      if (!allowFallback || _usingFallback) {
        NetworkResponseHandler.throwFromDio(error);
      }
      _usingFallback = true;
      try {
        return await _performGet(
          path: path,
          parser: parser,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
        );
      } on DioException catch (fallbackError) {
        NetworkResponseHandler.throwFromDio(fallbackError);
      }
    } on NetworkException {
      if (!allowFallback || _usingFallback) {
        rethrow;
      }
      _usingFallback = true;
      return _performGet(
        path: path,
        parser: parser,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    }
  }
  Future<ApiResponse<T>> _performGet<T>({
    required String path,
    required T Function(dynamic json) parser,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get<dynamic>(
      '$_baseUrl$path',
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
    final statusCode = response.statusCode;
    if (statusCode == null || statusCode < 200 || statusCode >= 300) {
      throw NetworkException(
        'Request failed with status $statusCode',
        code: 'http_$statusCode',
      );
    }
    return NetworkResponseHandler.handleSuccess(response, parser);
  }
}
