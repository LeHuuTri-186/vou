import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vou/core/di/service_locator.dart';
import 'package:vou/core/network/api_interceptors.dart';
import 'package:vou/core/storage/hive_service.dart';
import 'package:vou/features/authentication/bloc/sign_up_form_cubit.dart';
import 'package:vou/features/authentication/domain/repositories/auth_repository.dart';
import 'package:vou/features/authentication/domain/usecases/request_otp_usecase.dart';
import 'package:vou/features/authentication/domain/usecases/sign_up_usecase.dart';

import '../../../features/authentication/data/datasources/auth_api_datasource.dart';
import '../../../features/authentication/data/repositories/auth_repository_impl.dart';
import '../../../features/authentication/domain/usecases/sign_in_usecase.dart';
import '../../../features/authentication/domain/usecases/sign_out_usecase.dart';

void setUpAuthModule() {
  Dio dio = Dio();

  dio.options.baseUrl = dotenv.env['BASE_URL'] ?? '';

  dio.interceptors.add(
    $serviceLocator<SharedInterceptor>(),
  );

  // Datasource setup
  $serviceLocator.registerLazySingleton<AuthApiDataSource>(
      () => AuthApiDataSource(dio: dio));

  // Repository setup
  $serviceLocator.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(
          datasource: $serviceLocator<AuthApiDataSource>(),
          hiveService: $serviceLocator<HiveService>()));

  // UseCase setup
  $serviceLocator
      .registerLazySingleton<RequestOtpUseCase>(() => RequestOtpUseCase(
            repository: $serviceLocator<AuthRepository>(),
          ));
  $serviceLocator.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(
        repository: $serviceLocator<AuthRepository>(),
      ));
  $serviceLocator.registerLazySingleton<SignInUseCase>(() => SignInUseCase(
        repository: $serviceLocator<AuthRepository>(),
      ));

  $serviceLocator.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(
        repository: $serviceLocator<AuthRepository>(),
      ));

  // Bloc setup
  $serviceLocator
      .registerLazySingleton<SignUpFormCubit>(() => SignUpFormCubit());
}
