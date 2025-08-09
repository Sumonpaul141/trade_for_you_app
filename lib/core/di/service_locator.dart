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
import 'package:trade_for_you_app/features/order/data/data_source/trade_remote_data_source.dart';
import 'package:trade_for_you_app/features/order/domain/repositories/trade_repository.dart';
import 'package:trade_for_you_app/features/order/domain/use_cases/cancel_order_use_case.dart';
import 'package:trade_for_you_app/features/order/domain/use_cases/get_pairs_use_cases.dart';
import 'package:trade_for_you_app/features/order/domain/use_cases/place_order_use_case.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<ApiClient>(() => DioClient(sl(), sl()));
  sl.registerLazySingleton<LocalCacheService>(
    () => LocalCacheServiceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<TradeRemoteDataSource>(
    () => TradeRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<TradeRepository>(() => TradeRepositoryImpl(sl()));

  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => GetLoggedInUserUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetPairUseCases(sl()));
  sl.registerLazySingleton(() => PlaceOrderUseCase(sl()));
  sl.registerLazySingleton(() => CancelOrderUseCase(sl()));
}
