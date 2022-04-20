import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rest_api_package/rest_api_package.dart';
import 'core/services/location_service.dart';
import 'core/services/scanned_video_service.dart';
import 'data/datasources/hive_data_source.dart';

import 'core/platform/network_info.dart';
import 'data/datasources/http_data_source.dart';
import 'data/datasources/local_json_data_source.dart';
import 'data/provider/data_provider.dart';
import 'domain/repositories/data_repository.dart';
import 'domain/repositories/local_data_repository.dart';
import 'domain/repositories/remote_data_repository.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //!Features
  //Usecases
  //locator.registerLazySingleton(() => GetOffers(locator()));
  //locator.registerLazySingleton(() => GetProducts(locator()));

  //Repository
  locator.registerLazySingleton<DataRepository>(
    () => DataProvider(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  //Data
  final hiveDataSource = HiveDataSource();
  await hiveDataSource.init();
  locator.registerLazySingleton<LocalDataRepository>(
    () => hiveDataSource,
  );

  locator.registerLazySingleton<RemoteDataRepository>(
    () => HttpDataSource(),
  );

  //!Core
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(locator(), [
      ConnectivityResult.wifi,
    ]),
  );
  locator.registerLazySingleton<ScannedVideoService>(
    () => ScannedVideoService(),
  );
  locator.registerLazySingleton<LocationService>(
    () => LocationServiceImpl(),
  );
  locator.registerLazySingleton<RestApiHttpService>(
    () => RestApiHttpService(Dio(), DefaultCookieJar()),
  );

  //!External
  locator.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
}
