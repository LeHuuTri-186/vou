import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../storage/hive_service.dart';

class SharedInterceptor extends Interceptor {
  final HiveService _hiveService;
  final Dio _dio;

  SharedInterceptor({required HiveService hiveService, required Dio dio}): _hiveService = hiveService, _dio = dio;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = _hiveService.get('accessToken');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 400) {

      handler.resolve(
        Response(
          requestOptions: err.requestOptions,
          statusCode: 201,
          data: {'message': '400 error handled internally'},
        ),
      );
      return;
    }

    if (err.response?.statusCode == 401) {
      final refreshToken = _hiveService.get('refreshToken');
      final userId = _hiveService.get('userId');
      if (refreshToken != null) {
        try {
          debugPrint('refresh Token: $refreshToken, userId: $userId');
          final response = await Dio().post(dotenv.env['REFRESH_TOKEN_END_POINT'] ?? '', data: {
            'userId': userId,
            'refreshToken': refreshToken,
          });

          final newAccessToken = response.data['accessToken'];
          _hiveService.save('accessToken', newAccessToken);

          // Retry the failed request
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $newAccessToken';

          final retryResponse = await _dio.request(
            opts.path,
            options: Options(
              method: opts.method,
              headers: opts.headers,
            ),
            data: opts.data,
            queryParameters: opts.queryParameters,
          );

          return handler.resolve(retryResponse);
        } catch (e) {
          return handler.next(err);
        }
      }
    }
    super.onError(err, handler);
  }
}
