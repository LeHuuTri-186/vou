import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'api_interceptors.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl: '${dotenv.env['EVENT_API_BASE_URL']}', // Replace with your base URL
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    ));

    _dio.interceptors.add(ApiInterceptors()); // Add custom interceptors
  }

  Dio get dio => _dio;
}
