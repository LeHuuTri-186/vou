
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vou/core/di/service_locator.dart';
import 'package:vou/core/network/api_interceptors.dart';
import 'package:vou/core/storage/hive_service.dart';

void setUpApiInterceptorsModule() {
  final HiveService hiveService = HiveService();
  final Dio dio = Dio();

  dio.options.baseUrl = dotenv.env['AUTH_API_BASE_URL'] ?? '';
  $serviceLocator.registerLazySingleton<HiveService>(() => hiveService);
  $serviceLocator.registerLazySingleton<SharedInterceptor>(() => SharedInterceptor(hiveService: hiveService, dio: dio));
}