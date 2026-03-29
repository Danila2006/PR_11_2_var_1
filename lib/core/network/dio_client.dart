import 'package:dio/dio.dart';
import '../storage/token_storage.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

class DioClient {
  late Dio dio;

  DioClient(TokenStorage storage) {
    dio = Dio(BaseOptions(
      baseUrl: "https://reqres.in/api",
    ));

    dio.interceptors.addAll([
      LoggingInterceptor(),
      AuthInterceptor(storage, dio),
      ErrorInterceptor(),
    ]);
  }
}