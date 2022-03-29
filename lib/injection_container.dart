import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stipra/core/services/scanned_video_service.dart';
import 'package:stipra/data/datasources/hive_data_source.dart';

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
    () => NetworkInfoImpl(locator()),
  );
  locator.registerLazySingleton<ScannedVideoService>(
    () => ScannedVideoService(),
  );

  //!External
  locator.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
}
