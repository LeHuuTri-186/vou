import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vou/core/storage/hive_service.dart';
import 'package:vou/features/event/domain/usecases/get_user_live_usecase.dart';
import 'package:vou/features/shaker_game/bloc/puzzle_start_cubit.dart';
import 'package:vou/features/shaker_game/bloc/shaker_cubit.dart';
import 'package:vou/features/shaker_game/domain/usecases/get_user_puzzles_usecase.dart';
import 'package:vou/features/shaker_game/domain/usecases/join_event_usecase.dart';
import 'package:vou/features/shaker_game/domain/usecases/shake_puzzle_usecase.dart';

import '../../../features/shaker_game/data/datasources/puzzle_api_datasource.dart';
import '../../../features/shaker_game/data/repositories/puzzle_repository_impl.dart';
import '../../../features/shaker_game/domain/repositories/puzzle_repository.dart';
import '../../../features/shaker_game/domain/usecases/exchange_use_case.dart';
import '../../../features/shaker_game/domain/usecases/get_puzzle_detail_usecase.dart';
import '../../network/api_interceptors.dart';
import '../service_locator.dart';

void setUpPuzzleModule() {
  Dio dio = Dio();

  dio.options.baseUrl = dotenv.env['BASE_URL'] ?? '';

  dio.interceptors.add(
    $serviceLocator<SharedInterceptor>(),
  );

  // Datasource setup
  $serviceLocator.registerLazySingleton<PuzzleApiDataSource>(
    () => PuzzleApiDataSource(
      dio: dio,
    ),
  );

  // Repository setup
  $serviceLocator.registerLazySingleton<PuzzleRepository>(
    () => PuzzleRepositoryImpl(
      dataSource: $serviceLocator<PuzzleApiDataSource>(),
      hiveService: $serviceLocator<HiveService>(),
    ),
  );

  // UseCase setup
  $serviceLocator.registerLazySingleton<GetUserPuzzleUseCase>(
    () => GetUserPuzzleUseCase(
      repository: $serviceLocator<PuzzleRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<GetPuzzleDetailUseCase>(
    () => GetPuzzleDetailUseCase(
      repository: $serviceLocator<PuzzleRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<ExchangeUseCase>(
        () => ExchangeUseCase(
      repository: $serviceLocator<PuzzleRepository>(),
    ),
  );


  $serviceLocator.registerLazySingleton<JoinPuzzleGameUseCase>(
        () => JoinPuzzleGameUseCase(
      repository: $serviceLocator<PuzzleRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<ShakePuzzleUseCase>(
        () => ShakePuzzleUseCase(
      repository: $serviceLocator<PuzzleRepository>(),
    ),
  );

  // Bloc setup

  $serviceLocator.registerLazySingleton<PuzzleStartCubit>(
    () => PuzzleStartCubit(
      getUserLiveUseCase: $serviceLocator<GetUserLiveUseCase>(),
      getPuzzleDetailUseCase: $serviceLocator<GetPuzzleDetailUseCase>(),
      getUserPuzzleUseCase: $serviceLocator<GetUserPuzzleUseCase>(),
      joinPuzzleGameUseCase: $serviceLocator<JoinPuzzleGameUseCase>(),
      exchangeUseCase: $serviceLocator<ExchangeUseCase>(),
    ),
  );

  $serviceLocator.registerLazySingleton<ShakerCubit>(
      () => ShakerCubit(getUserLiveUseCase: $serviceLocator<GetUserLiveUseCase>(), shakePuzzleUseCase: $serviceLocator<ShakePuzzleUseCase>()),
  );
}
