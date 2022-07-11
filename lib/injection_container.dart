import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rest_api_package/rest_api_package.dart';
import 'package:stipra/core/services/log_service.dart';
import 'package:stipra/core/utils/lottie/lottie_cache.dart';
import 'core/services/permission_service.dart';
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

//* This class creating a singleton instance of the dependency injection container
//* Then we can use it in the whole application as generic
//* It is providing us access to the controllers and services and etc.

//* Get general singleton with plugin
final locator = GetIt.instance;
bool isDebugMode = false;

Future<void> init() async {
  //* We will use these usecases in future (for clean code) currently we are not using usecases.
  //!Features
  //Usecases
  //locator.registerLazySingleton(() => GetOffers(locator()));
  //locator.registerLazySingleton(() => GetProducts(locator()));

  //* We are saving data repository to singleton so we can access it from everywhere
  //Repository
  locator.registerLazySingleton<DataRepository>(
    () => DataProvider(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  //* We are saving local database + remote database sources in singleton so we can access it from everywhere
  //Data
  final hiveDataSource = HiveDataSource();
  await hiveDataSource.init();
  locator.registerLazySingleton<LocalDataRepository>(
    () => hiveDataSource,
  );

  locator.registerLazySingleton<RemoteDataRepository>(
    () => HttpDataSource(),
  );

  //* We are saving network service + scanned video service + location service + permission service + http service
  //* in singleton so we can access it from everywhere
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
  locator.registerLazySingleton<PermissionService>(
    () => PermissionServiceImpl(),
  );
  locator.registerLazySingleton<RestApiHttpService>(
    () => RestApiHttpService(Dio(), DefaultCookieJar()),
  );
  locator.registerLazySingleton<LogService>(
    () => LogService(),
  );

  //!External
  locator.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
  locator.registerLazySingleton<LottieCache>(
    () => LottieCache(),
  );
}
