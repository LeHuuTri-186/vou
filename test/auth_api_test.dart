import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:vou/features/authentication/data/datasources/auth_api_datasource.dart';
import 'package:vou/features/event/data/datasources/event_api_datasource.dart';

void main() {
  late Dio dio;
  late AuthApiDatasource datasource;
  late DioAdapter dioAdapter;

  setUp(
        () async {
      dio = Dio();
      await dotenv.load(fileName: ".env");
      dio.options.baseUrl = dotenv.env['AUTH_API_BASE_URL'] ?? '';

      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;
      datasource = AuthApiDatasource(dio: dio);
    },
  );

  group(
    'Auth API Tests',
        () {
      test(
        'register success',
            () async {
          final endpoint = dotenv.env['EVENT_END_POINT'] ?? '';
          dioAdapter.onGet(
            endpoint,
                (server) => server.reply(
              200,
              {
                'message': 'Success',
              },
            ),
          );
        },
      );
    },
  );
}
