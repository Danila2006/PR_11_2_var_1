import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/token_storage.dart';
import '../../../main.dart';
import '../data/auth_service.dart';

final authServiceProvider = Provider((ref) {
  return AuthService(ref.read(dioProvider), ref.read(tokenStorageProvider));
});

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier(ref.read(authServiceProvider));
});

class AuthNotifier extends StateNotifier<bool> {
  final AuthService service;

  AuthNotifier(this.service) : super(false);

  Future<void> login(String email, String password) async {
    await service.login(email, password);
    state = true;
  }

  Future<void> logout() async {
    await service.logout();
    state = false;
  }
}