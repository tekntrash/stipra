import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stipra/core/platform/network_info.dart';
import 'package:stipra/data/datasources/local/local_data_source.dart';
import 'package:stipra/data/datasources/local/local_json_data_source.dart';
import 'package:stipra/data/datasources/remote/remote_data_source.dart';
import 'package:stipra/data/datasources/remote/remote_data_source_impl.dart';
import 'package:stipra/data/provider/data_provider.dart';
import 'package:stipra/domain/repositories/data_repository.dart';
import 'package:stipra/domain/usecases/get_offers.dart';
import 'package:stipra/domain/usecases/get_products.dart';

final locator = GetIt.instance;

void init() {
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
  locator.registerLazySingleton<LocalDataSource>(
    () => JsonLocalDataSource(),
  );
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(),
  );

  //!Core
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(locator()),
  );

  //!External
  locator.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
}
