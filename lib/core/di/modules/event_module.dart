import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vou/core/di/service_locator.dart';
import 'package:vou/core/network/api_interceptors.dart';
import 'package:vou/core/storage/hive_service.dart';
import 'package:vou/features/event/bloc/event_cubit.dart';
import 'package:vou/features/event/data/datasources/event_api_datasource.dart';
import 'package:vou/features/event/data/datasources/game_in_event_datasource.dart';
import 'package:vou/features/event/data/repositories/event_repository_impl.dart';
import 'package:vou/features/event/domain/repositories/event_repository.dart';
import 'package:vou/features/event/domain/repositories/game_in_event_repository.dart';
import 'package:vou/features/event/domain/usecases/get_all_event_usecase.dart';
import 'package:vou/features/event/domain/usecases/join_event_usecase.dart';
import 'package:vou/features/event/domain/usecases/leave_event_usecase.dart';

import '../../../features/event/bloc/game_detail_cubit.dart';
import '../../../features/event/bloc/game_in_event_cubit.dart';
import '../../../features/event/data/repositories/game_in_event_repository_impl.dart';
import '../../../features/event/domain/usecases/get_all_game_in_event_usecase.dart';
import '../../../features/event/domain/usecases/get_event_by_filter_usecase.dart';
import '../../../features/event/domain/usecases/get_event_detail_usecase.dart';
import '../../../features/event/domain/usecases/get_game_detail_usecase.dart';
import '../../../features/event/domain/usecases/get_game_type_usecase.dart';
import '../../../features/event/domain/usecases/get_user_live_usecase.dart';
import '../../../features/event/domain/usecases/like_event_usecase.dart';
import '../../../features/event/domain/usecases/unlike_event_usecase.dart';

void setUpEventModule() {
  Dio eventDio = Dio();

  eventDio.options.baseUrl = dotenv.env['BASE_URL'] ?? '';

  eventDio.interceptors.add(
    $serviceLocator<SharedInterceptor>(),
  );

  // Datasource setup
  setUpDataSource(eventDio);

  // Repository setup
  setUpRepository();

  // UseCase setup
  setUpUsecase();

  // Bloc setup
  setUpBloc();
}

void setUpBloc() {
  $serviceLocator.registerLazySingleton<EventCubit>(
    () => EventCubit(
      likeEventUseCase: $serviceLocator<LikeEventUseCase>(),
      unlikeEventUseCase: $serviceLocator<UnlikeEventUseCase>(),
      getEventByFilterUseCase: $serviceLocator<GetEventByFilterUseCase>(),
    ),
  );

  $serviceLocator.registerLazySingleton<GameCubit>(
    () => GameCubit(
      leaveEventUseCase: $serviceLocator<LeaveEventUseCase>(),
      joinEventUseCase: $serviceLocator<JoinEventUseCase>(),
      getAllGameInEventUseCase: $serviceLocator<GetAllGameInEventUseCase>(),
      getEventDetailUseCase: $serviceLocator<GetEventDetailUseCase>(),
      getUserLiveUseCase: $serviceLocator<GetUserLiveUseCase>(),
    ),
  );

  $serviceLocator.registerLazySingleton<GameDetailCubit>(
    () => GameDetailCubit(
      getUserLiveUseCase: $serviceLocator<GetUserLiveUseCase>(),
      getGameDetailUseCase: $serviceLocator<GetGameDetailUseCase>(),
      getGameTypeUseCase: $serviceLocator<GetGameTypeUseCase>(),
    ),
  );
}

void setUpDataSource(Dio eventDio) {
  $serviceLocator.registerLazySingleton<EventApiDataSource>(
    () => EventApiDataSource(
      dio: eventDio,
    ),
  );

  $serviceLocator.registerLazySingleton<GameInEventDataSource>(
    () => GameInEventDataSource(
      dio: eventDio,
    ),
  );
}

void setUpRepository() {
  $serviceLocator.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(
      hiveService: $serviceLocator<HiveService>(),
      datasource: $serviceLocator<EventApiDataSource>(),
    ),
  );

  $serviceLocator.registerLazySingleton<GameInEventRepository>(
    () => GameInEventRepositoryImpl(
        dataSource: $serviceLocator<GameInEventDataSource>(),
        hiveService: $serviceLocator<HiveService>()),
  );
}

void setUpUsecase() {
  $serviceLocator.registerLazySingleton<GetAllEventUseCase>(
    () => GetAllEventUseCase(
      repository: $serviceLocator<EventRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<GetEventByFilterUseCase>(
    () => GetEventByFilterUseCase(
      repository: $serviceLocator<EventRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<LikeEventUseCase>(
    () => LikeEventUseCase(
      repository: $serviceLocator<EventRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<UnlikeEventUseCase>(
    () => UnlikeEventUseCase(
      repository: $serviceLocator<EventRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<GetAllGameInEventUseCase>(
    () => GetAllGameInEventUseCase(
      repository: $serviceLocator<GameInEventRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<GetGameDetailUseCase>(
    () => GetGameDetailUseCase(
      repository: $serviceLocator<GameInEventRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<GetEventDetailUseCase>(
    () => GetEventDetailUseCase(
      repository: $serviceLocator<GameInEventRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<GetUserLiveUseCase>(
    () => GetUserLiveUseCase(
      repository: $serviceLocator<GameInEventRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<JoinEventUseCase>(
    () => JoinEventUseCase(
      repository: $serviceLocator<GameInEventRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<LeaveEventUseCase>(
    () => LeaveEventUseCase(
      repository: $serviceLocator<GameInEventRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<GetGameTypeUseCase>(
    () => GetGameTypeUseCase(
      repository: $serviceLocator<GameInEventRepository>(),
    ),
  );
}
