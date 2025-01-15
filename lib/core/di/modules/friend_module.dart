import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vou/core/storage/hive_service.dart';
import 'package:vou/features/event/domain/usecases/get_user_live_usecase.dart';
import 'package:vou/features/friend/bloc/friend_cubit.dart';
import 'package:vou/features/friend/domain/usecases/find_friend_usecase.dart';
import 'package:vou/features/friend/domain/usecases/share_turn_usecase.dart';

import '../../../features/friend/bloc/friend_search_cubit.dart';
import '../../../features/friend/bloc/friend_share_cubit.dart';
import '../../../features/friend/data/datasources/friend_api_datasource.dart';
import '../../../features/friend/data/repositories/friend_repository_impl.dart';
import '../../../features/friend/domain/repositories/friend_repository.dart';
import '../../../features/friend/domain/usecases/add_friend_usecase.dart';
import '../../../features/friend/domain/usecases/get_friend_list_usecase.dart';
import '../../../features/friend/domain/usecases/unfriend_usecase.dart';
import '../../network/api_interceptors.dart';
import '../service_locator.dart';

void setUpFriendModule() {
  Dio dio = Dio();

  dio.options.baseUrl = dotenv.env['BASE_URL'] ?? '';

  dio.interceptors.add(
    $serviceLocator<SharedInterceptor>(),
  );

  // Datasource setup
  $serviceLocator.registerLazySingleton<FriendApiDatasource>(
        () => FriendApiDatasource(
      dio: dio,
    ),
  );

  // Repository setup
  $serviceLocator.registerLazySingleton<FriendRepository>(
        () => FriendRepositoryImpl(
      datasource: $serviceLocator<FriendApiDatasource>(),
          hiveService: $serviceLocator<HiveService>(),
    ),
  );

  // UseCase setup
  $serviceLocator.registerLazySingleton<GetFriendListUseCase>(
        () => GetFriendListUseCase(repository: $serviceLocator<FriendRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<FindFriendUseCase>(
        () => FindFriendUseCase(
      repository: $serviceLocator<FriendRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<AddFriendUseCase>(
        () => AddFriendUseCase(
      repository: $serviceLocator<FriendRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<UnfriendUseCase>(
        () => UnfriendUseCase(
      repository: $serviceLocator<FriendRepository>(),
    ),
  );

  $serviceLocator.registerLazySingleton<ShareTurnUseCase>(
        () => ShareTurnUseCase(repository: $serviceLocator<FriendRepository>(),
    ),
  );

  // Bloc setup
  $serviceLocator.registerLazySingleton<FriendCubit>(
      () => FriendCubit(getFriendListUseCase: $serviceLocator<GetFriendListUseCase>(), unfriendUseCase: $serviceLocator<UnfriendUseCase>())
  );
  $serviceLocator.registerLazySingleton<FriendSearchCubit>(
          () => FriendSearchCubit(addFriendUseCase: $serviceLocator<AddFriendUseCase>(), findFriendUseCase: $serviceLocator<FindFriendUseCase>())
  );

  $serviceLocator.registerLazySingleton<FriendShareCubit>(
          () => FriendShareCubit(shareTurnUseCase: $serviceLocator<ShareTurnUseCase>(), getUserLiveUseCase: $serviceLocator<GetUserLiveUseCase>(), getFriendListUseCase: $serviceLocator<GetFriendListUseCase>(),)
  );
}
