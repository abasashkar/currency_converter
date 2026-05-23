import 'package:currency_app/common/constants/api_constants.dart';
import 'package:currency_app/common/services/dio_logging_interceptor.dart';
import 'package:dio/dio.dart';
Dio createDio() {
  final dio = Dio(
    BaseOptions(
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: const {
        'Accept': 'application/json',
      },
      responseType: ResponseType.json,
      validateStatus: (status) => status != null && status < 500,
    ),
  );
  dio.interceptors.add(DioLoggingInterceptor());
  return dio;
}
