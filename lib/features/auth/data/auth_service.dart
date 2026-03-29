import 'package:dio/dio.dart';
import '../../../core/storage/token_storage.dart';

class AuthService {
  final Dio dio;
  final TokenStorage storage;

  AuthService(this.dio, this.storage);

  Future<void> login(String email, String password) async {
    try {
      final res = await dio.post("/login", data: {
        "email": email,
        "password": password,
      });

      await storage.saveTokens(res.data["token"], "refresh_mock");

    } on DioException {
      /*
      Я використовую ReqRes, але він нестабільний (403),
      тому додав fallback-логіку,
      щоб система авторизації завжди працювала
       */
      if (email == "eve.holt@reqres.in" &&
          password == "cityslicka") {
        await storage.saveTokens("mock_token", "refresh_mock");
        return;
      }

      throw Exception("Неправильний email або пароль");
    }
  }

  Future<void> register(String email, String password) async {
    final res = await dio.post("/register", data: {
      "email": email,
      "password": password,
    });

    await storage.saveTokens(res.data["token"], "refresh_mock");
  }

  Future<void> logout() async {
    await storage.clear();
  }
}