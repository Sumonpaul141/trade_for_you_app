import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_for_you_app/core/network/api_client.dart';
import 'package:trade_for_you_app/core/network/dio_client.dart';
import 'package:trade_for_you_app/core/services/local_cache_service.dart';
import 'package:trade_for_you_app/core/services/local_cache_service_impl.dart';
import 'package:trade_for_you_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:trade_for_you_app/features/auth/data/data_sources/user_local_data_source.dart';
import 'package:trade_for_you_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:trade_for_you_app/features/auth/domain/usecases/get_logged_in_user_usecase.dart';
import 'package:trade_for_you_app/features/auth/domain/usecases/logout_use_case.dart';
import 'package:trade_for_you_app/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:trade_for_you_app/features/order/data/data_source/order_remote_data_source.dart';
import 'package:trade_for_you_app/features/order/domain/repositories/order_repository.dart';
import 'package:trade_for_you_app/features/order/domain/use_cases/get_pairs_use_cases.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<ApiClient>(() => DioClient(Dio()));
  sl.registerLazySingleton<LocalCacheService>(
    () => LocalCacheServiceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl()));

  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => GetLoggedInUserUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetPairUseCases(sl()));
}
