import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vou/core/di/service_locator.dart';
import 'package:vou/core/network/token_manager.dart';

setUpTokenManagerModule() {
  final Dio dio = Dio();

  dio.options.baseUrl = dotenv.env['AUTH_API_BASE_URL'] ?? '';

  $serviceLocator.registerLazySingleton<TokenManager>(
    () => TokenManager(
      dio: dio,
    ),
  );
}
