import 'package:dartz/dartz.dart';

import '../../../../core/platform/network_info.dart';
import '../../core/errors/exception.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/offer.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/data_repository.dart';
import '../../domain/repositories/local_data_repository.dart';
import '../../domain/repositories/remote_data_repository.dart';

class DataProvider implements DataRepository {
  final RemoteDataRepository remoteDataSource;
  final LocalDataRepository localDataSource;
  final NetworkInfo networkInfo;

  DataProvider({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Offer>>> getOffers() async {
    return await _getDataList(
      getData: remoteDataSource.getOffers,
      saveCache: localDataSource.cacheOffers,
      getCache: localDataSource.getLastOffers,
    );
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    return await _getDataList(
      getData: remoteDataSource.getProducts,
      saveCache: localDataSource.cacheProducts,
      getCache: localDataSource.getLastProducts,
    );
  }

  Future<Either<Failure, T>> _getDataList<T, K extends T>({
    required Future<K> Function() getData,
    required Future<void> Function(K) saveCache,
    required Future<T> Function() getCache,
  }) async {
    if (false) {
      //await networkInfo.isConnected
      try {
        final remoteData = await getData();
        saveCache(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localData = await getCache();
        return Right(localData);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> sendBarcode(String barcode) async {
    try {
      final remoteData = await remoteDataSource.sendBarcode(barcode);
      return Right(remoteData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> sendScannedVideo(String videoPath) async {
    try {
      final remoteData = await remoteDataSource.sendScannedVideo(videoPath);
      return Right(remoteData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
