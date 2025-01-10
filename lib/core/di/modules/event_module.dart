import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vou/core/di/service_locator.dart';
import 'package:vou/features/event/bloc/event_cubit.dart';
import 'package:vou/features/event/data/datasources/event_api_datasource.dart';
import 'package:vou/features/event/data/repositories/event_repository_impl.dart';
import 'package:vou/features/event/domain/repositories/event_repository.dart';
import 'package:vou/features/event/domain/usecases/get_all_event_usecase.dart';

void setUpEventModule() {
  Dio dio = Dio();

  dio.options.baseUrl = dotenv.env['EVENT_API_BASE_URL'] ?? '';

  dio.interceptors.add(
    _setUpInterceptorsWrapper(),
  );

  // Datasource setup
  $serviceLocator.registerLazySingleton<EventApiDatasource>(
    () => EventApiDatasource(
      dio: dio,
    ),
  );

  // Repository setup
  $serviceLocator.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(
      datasource: $serviceLocator<EventApiDatasource>(),
    ),
  );

  // UseCase setup
  $serviceLocator.registerLazySingleton<GetAllEventUseCase>(
    () => GetAllEventUseCase(
      repository: $serviceLocator<EventRepository>(),
    ),
  );

  // Bloc setup
  $serviceLocator.registerLazySingleton<EventCubit>(
    () => EventCubit(
      getAllEventUseCase: $serviceLocator<GetAllEventUseCase>(),
    ),
  );
}

InterceptorsWrapper _setUpInterceptorsWrapper() {
  return InterceptorsWrapper(
    onRequest: (
      options,
      handler,
    ) async {
      options.headers = {
        'Content-Type': 'application/json',
      };
      return handler.next(
        options,
      );
    },
    onResponse: (
      response,
      handler,
    ) {
      return handler.next(
        response,
      );
    },
    onError: (
      DioException error,
      handler,
    ) async {
      if (error.response?.statusCode == 401) {
        return handler.reject(
          error,
        );
      }
      return handler.next(
        error,
      );
    },
  );
}
