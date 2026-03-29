import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/network/dio_client.dart';
import 'core/storage/token_storage.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/auth/presentation/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final tokenStorageProvider = Provider((ref) => TokenStorage());
final dioProvider = Provider((ref) => DioClient(ref.read(tokenStorageProvider)).dio);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Root(),
    );
  }
}

class Root extends ConsumerStatefulWidget {
  const Root({super.key});

  @override
  ConsumerState<Root> createState() => _RootState();
}

class _RootState extends ConsumerState<Root> {
  bool? isAuth;

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future<void> checkAuth() async {
    final storage = ref.read(tokenStorageProvider);
    final token = await storage.getAccessToken();
    setState(() {
      isAuth = token != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isAuth == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return isAuth! ? const HomeScreen() : const LoginScreen();
  }
}