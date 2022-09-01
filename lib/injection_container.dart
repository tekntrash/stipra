import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rest_api_package/rest_api_package.dart';
import 'package:stipra/core/services/log_service.dart';
import 'package:stipra/core/utils/lottie/lottie_cache.dart';
import 'package:stipra/presentation/pages/loyalty_cards/data/providers/card_local_provider.dart';
import 'package:stipra/presentation/pages/loyalty_cards/data/services/card_service.dart';
import 'core/services/notification_service.dart';
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
import 'injection_container.config.dart';

//* This class creating a singleton instance of the dependency injection container
//* Then we can use it in the whole application as generic
//* It is providing us access to the controllers and services and etc.

//* Get general singleton with plugin
final locator = GetIt.instance;
bool isDebugMode = false;

late final DataType environmentTag;

enum DataType {
  real,
  mock,
}

@InjectableInit(
  generateForDir: [
    'lib',
  ], // <-- Generate for these directories içinde parametere var başka pluginlerden işe yaramaz.
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> init() async {
  //* We will use these usecases in future (for clean code) currently we are not using usecases.
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
  locator.registerLazySingleton<PermissionService>(
    () => PermissionServiceImpl(),
  );
  locator.registerLazySingleton<RestApiHttpService>(
    () => RestApiHttpService(
      Dio(),
      DefaultCookieJar(),
      'https://api.stipra.com/',
    ),
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
  final notificationService = NotificationService();
  await notificationService.init();
  locator.registerLazySingleton<NotificationService>(
    () => notificationService,
  );

  //! Automatic locator's   initialization
  await _initSource<CardLocalProvider>(
    source: CardLocalProvider(),
  );

  const String envDataType = const String.fromEnvironment("DATA_TYPE");
  environmentTag =
      DataType.values.firstWhere((element) => element.name == envDataType);
  //!Automatic locator
  $initGetIt(
    locator,
    environment: envDataType,
  );
}

Future<void> _initSource<T extends Object>({required source}) async {
  await source.init();
  locator.registerLazySingleton<T>(
    () => source,
  );
}
