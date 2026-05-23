import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    assert(() {
      debugPrint('[DIO] ${options.method} ${options.uri}');
      return true;
    }());
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    assert(() {
      debugPrint('[DIO ERROR] ${err.type} ${err.message}');
      return true;
    }());
    handler.next(err);
  }
}
