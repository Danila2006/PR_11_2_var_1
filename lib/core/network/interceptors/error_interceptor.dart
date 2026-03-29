import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String message = "Unknown error";

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout";
        break;
      case DioExceptionType.badResponse:
        message = "Server error: ${err.response?.statusCode}";
        break;
      default:
        message = "Error occurred";
    }

    handler.next(DioException(
      requestOptions: err.requestOptions,
      error: message,
    ));
  }
}