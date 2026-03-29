import 'package:dio/dio.dart';
import '../../storage/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage storage;
  final Dio dio;

  AuthInterceptor(this.storage, this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await storage.getAccessToken();
    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final refresh = await storage.getRefreshToken();

        final response = await dio.post("/refresh", data: {
          "refresh_token": refresh,
        });

        final newToken = response.data["access_token"];

        await storage.saveTokens(newToken, refresh!);

        final retry = await dio.fetch(err.requestOptions);
        return handler.resolve(retry);
      } catch (e) {
        await storage.clear();
      }
    }

    handler.next(err);
  }
}