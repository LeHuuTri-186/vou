import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:vou/features/event/data/datasources/event_api_datasource.dart';

void main() {
  late Dio dio;
  late EventApiDatasource eventApiDatasource;
  late DioAdapter dioAdapter;

  setUp(
    () async {
      dio = Dio();
      await dotenv.load(fileName: ".env");
      dio.options.baseUrl = dotenv.env['EVENT_API_BASE_URL'] ?? '';

      dioAdapter = DioAdapter(dio: dio);
      dio.httpClientAdapter = dioAdapter;
      eventApiDatasource = EventApiDatasource(dio: dio);
    },
  );

  group(
    'Event API Tests',
    () {
      test(
        'fetchData returns valid response',
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
