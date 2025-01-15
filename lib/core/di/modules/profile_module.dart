import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vou/features/profile/domain/usecases/get_user_detail_usecase.dart';

import '../../../features/profile/bloc/user_cubit.dart';
import '../../../features/profile/data/datasources/user_api_datasource.dart';
import '../../../features/profile/data/repositories/user_repository_impl.dart';
import '../../../features/profile/domain/repositories/user_repository.dart';
import '../../../features/profile/domain/usecases/update_user_usecase.dart';
import '../../network/api_interceptors.dart';
import '../service_locator.dart';

void setUpProfileModule() {
  Dio dio = Dio();

  dio.options.baseUrl = dotenv.env['BASE_URL'] ?? '';

  dio.interceptors.add(
    $serviceLocator<SharedInterceptor>(),
  );

  // Datasource setup
  $serviceLocator.registerLazySingleton<UserApiDataSource>(
    () => UserApiDataSource(
      dio: dio,
    ),
  );

  // Repository setup
  $serviceLocator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      dataSource: $serviceLocator<UserApiDataSource>(),
    ),
  );

  // UseCase setup
  $serviceLocator.registerLazySingleton<GetUserDetailUseCase>(
    () => GetUserDetailUseCase(
      userRepository: $serviceLocator<UserRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<UpdateUserUseCase>(
    () => UpdateUserUseCase(
      userRepository: $serviceLocator<UserRepository>(),
    ),
  );

  // Bloc setup
  $serviceLocator.registerLazySingleton<UserCubit>(
    () => UserCubit(
      getUserDetailUseCase: $serviceLocator<GetUserDetailUseCase>(),
      updateUserUseCase: $serviceLocator<UpdateUserUseCase>(),
    ),
  );
}
