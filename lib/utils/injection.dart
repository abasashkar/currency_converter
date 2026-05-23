import 'package:currency_app/common/services/api_client.dart';
import 'package:currency_app/common/services/dio_factory.dart';
import 'package:currency_app/repo/currency_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  if (sl.isRegistered<Dio>()) return;

  sl.registerLazySingleton<Dio>(createDio);
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<Dio>()));
  sl.registerLazySingleton<CurrencyRepository>(
    () => CurrencyRepository(sl<ApiClient>()),
  );
}
