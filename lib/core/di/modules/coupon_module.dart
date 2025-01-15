import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vou/core/storage/hive_service.dart';
import 'package:vou/features/coupon/data/repositories/coupon_repository_impl.dart';
import 'package:vou/features/coupon/domain/repositories/coupon_repository.dart';
import 'package:vou/features/coupon/domain/usecases/get_user_coupon_usecase.dart';

import '../../../features/coupon/bloc/user_coupon_cubit.dart';
import '../../../features/coupon/data/datasources/coupon_api_datasource.dart';
import '../../network/api_interceptors.dart';
import '../service_locator.dart';

void setUpCouponModule() {
  Dio dio = Dio();

  dio.options.baseUrl = dotenv.env['BASE_URL'] ?? '';

  dio.interceptors.add(
    $serviceLocator<SharedInterceptor>(),
  );

  // Datasource setup
  $serviceLocator.registerLazySingleton<CouponApiDataSource>(
    () => CouponApiDataSource(
      dio: dio,
    ),
  );

  // Repository setup
  $serviceLocator.registerLazySingleton<CouponRepository>(
    () => CouponRepositoryImpl(
      dataSource: $serviceLocator<CouponApiDataSource>(),
      hiveService: $serviceLocator<HiveService>(),
    ),
  );

  // Usecase setup
  $serviceLocator.registerLazySingleton<GetUserCouponUseCase>(
        () => GetUserCouponUseCase(
          repository: $serviceLocator<CouponRepository>(),
    ),
  );

  // Bloc setup
  $serviceLocator.registerLazySingleton<UserCouponCubit>(
        () => UserCouponCubit(
          getUserCouponUseCase: $serviceLocator<GetUserCouponUseCase>(),
    ),
  );
}
