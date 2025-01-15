import 'package:vou/core/di/service_locator.dart';
import 'package:vou/core/storage/hive_service.dart';
import 'package:vou/features/quiz_game_socket/bloc/quiz_game_cubit.dart';
import 'package:vou/features/quiz_game_socket/data/quiz_game_socket_service.dart';

void setUpQuizModule() {
  $serviceLocator.registerLazySingleton<QuizGameSocketService>(
      () => QuizGameSocketService(hiveService: $serviceLocator<HiveService>())
  );

  $serviceLocator.registerLazySingleton<QuizGameCubit>(
      () => QuizGameCubit($serviceLocator<QuizGameSocketService>())
  );
}