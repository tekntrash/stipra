import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:stipra/data/enums/my_product_category.dart';
import 'package:stipra/data/models/food_fact_model.dart';
import 'package:stipra/data/models/my_trade_model.dart';
import 'package:stipra/data/models/privacy_model.dart';
import 'package:stipra/data/models/product_consumed_model.dart';
import 'package:stipra/data/models/search_dto_model.dart';
import 'package:stipra/domain/entities/search_dto.dart';
import 'package:stipra/domain/entities/win_item.dart';
import '../../core/services/log_service.dart';
import '../../domain/entities/trade_item.dart';
import '../../injection_container.dart';
import '../enums/change_email_action_type.dart';
import '../enums/change_password_action_type.dart';
import '../enums/change_profile_action_type.dart';
import '../enums/reset_password_action_type.dart';
import '../enums/sms_action_type.dart';
import '../enums/trade_point_category.dart';
import '../enums/win_point_category.dart';
import '../models/error_model.dart';
import '../models/profile_model.dart';
import '../models/trade_item_model.dart';
import '../models/user_model.dart';

import '../../../../core/platform/network_info.dart';
import '../../core/errors/exception.dart';
import '../../core/errors/failure.dart';
import '../../domain/entities/offer.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/data_repository.dart';
import '../../domain/repositories/local_data_repository.dart';
import '../../domain/repositories/remote_data_repository.dart';

/// This class is used for get data from data source
/// and return data
/// It is implements from [DataRepository] and uses
/// [RemoteDataRepository] and [LocalDataRepository] as data source

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
  Future<Either<Failure, void>> sendBarcode(
      String barcode,
      String barcodeTimestamp,
      String videoName,
      double latitude,
      double longitude) async {
    try {
      final remoteData = await remoteDataSource.sendBarcode(
          barcode, barcodeTimestamp, videoName, latitude, longitude);
      return Right(remoteData);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider sendBarcode',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> sendScannedVideo(
      String videoPath, String videoDate, double latitude, double longitude,
      {dynamic cancelToken, ValueNotifier<double>? progressNotifier}) async {
    try {
      final remoteData = await remoteDataSource.sendScannedVideo(
        videoPath,
        videoDate,
        latitude,
        longitude,
        cancelToken: cancelToken,
        progressNotifier: progressNotifier,
      );
      return Right(remoteData);
    } catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider SendScannedVideo',
          message:
              'Parameters: Progress notifier $progressNotifier, ------ ${e.toString()}',
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      if (e is ServerFailure) {
        return Left(e);
      }
      return Left(ServerFailure(errorMessage: '$e'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> login(String emailAddress, String password,
      bool? stayLoggedIn, String geo) async {
    try {
      final remoteData = await remoteDataSource.login(
          emailAddress, password, stayLoggedIn, geo);
      return Right(remoteData);
    } catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider login',
          message: 'E type: ${e.runtimeType} E as string: ${e.toString()}',
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      if (e is ServerFailure) {
        return Left(e);
      } else if (e is PhoneVerifyFailure) {
        return Left(e);
      }
      throw e;
    }
  }

  @override
  Future<Either<Failure, UserModel>> register(
    String emailAddress,
    String password,
    String name,
    String mobile,
    String countrycode,
    bool? stayLoggedIn,
    double latitude,
    double longitude,
  ) async {
    try {
      final remoteData = await remoteDataSource.register(emailAddress, password,
          name, mobile, countrycode, stayLoggedIn, latitude, longitude);
      return Right(remoteData);
    } catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider Register',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      if (e is ServerFailure) {
        return Left(e);
      }
      throw e;
    }
  }

  @override
  Future<Either<Failure, bool>> smsConfirm(
    SmsActionType action,
    String emailAddres,
    String userId,
  ) async {
    try {
      final remoteData =
          await remoteDataSource.smsConfirm(action, emailAddres, userId);
      return Right(remoteData);
    } catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider smsConfirm',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      if (e is ServerFailure) {
        return Left(e);
      } else if (e is PhoneSmsExceededLimit) {
        return Left(e);
      }
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(
    ResetPasswordActionType action,
    String emailAddress, {
    String? password,
  }) async {
    try {
      final remoteData = await remoteDataSource
          .resetPassword(action, emailAddress, password: password);
      return Right(remoteData);
    } catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider resetPassword',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      if (e is ServerFailure) {
        return Left(e);
      } else if (e is PhoneSmsExceededLimit) {
        return Left(e);
      } else if (e is PhoneVerifyFailure) {
        return Left(e);
      }
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> changePassword(
    ChangePasswordActionType action,
    String emailAddress,
    String userId, {
    String? oldpassword,
    String? newpassword,
  }) async {
    try {
      final remoteData = await remoteDataSource.changePassword(
          action, emailAddress, userId,
          oldpassword: oldpassword, newpassword: newpassword);
      return Right(remoteData);
    } catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider changePassword',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      if (e is ServerFailure) {
        return Left(e);
      } else if (e is PhoneSmsExceededLimit) {
        return Left(e);
      } else if (e is PhoneVerifyFailure) {
        return Left(e);
      }
      throw e;
    }
  }

  @override
  Future<Either<Failure, void>> callPythonForScannedVideo(String videoPath,
      String videoDate, double latitude, double longitude) async {
    try {
      final remoteData = await remoteDataSource.callPythonForScannedVideo(
          videoPath, videoDate, latitude, longitude);
      return Right(remoteData);
    } catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider callPythonForScannedVideo',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> changeProfilePicture(String imagePath) async {
    try {
      final remoteData = await remoteDataSource.changeProfilePicture(
        imagePath,
      );
      return Right(remoteData);
    } catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider changeProfilePicture',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> changeEmail(
    ChangeEmailActionType action,
    String emailAddress,
    String userId,
    String newEmail,
  ) async {
    try {
      final remoteData = await remoteDataSource.changeEmail(
        action,
        emailAddress,
        userId,
        newEmail,
      );
      return Right(remoteData);
    } on ServerException {
      return Left(ServerFailure());
    } on EmailVerifyFailure catch (e) {
      return Left(e);
    } on ServerFailure catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider changeEmail',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> changeProfile(
    ChangeProfileActionType action,
    dynamic profile,
  ) async {
    try {
      final remoteData = await remoteDataSource.changeProfile(
        action,
        profile,
      );
      return Right(remoteData);
    } on ServerFailure catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider changeprofile',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      return Left(e);
    }
  }

  //Todo add cache
  @override
  Future<Either<Failure, List<TradeItem>>> getTradePoints(
    TradePointCategory category,
    TradePointDirection direction,
    bool expired,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getTradePoints(
          category,
          direction,
          expired,
        );
        localDataSource.cacheLastTradePoints(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerFailure catch (e) {
        locator<LogService>().logError(
          ErrorModel(
            tag: 'DataProvider getTradePoints remote',
            message: e.toString(),
            timestamp: DateTime.now().millisecondsSinceEpoch,
            isUploaded: false,
          ),
        );
        return Left(e);
      }
    } else {
      try {
        final localData = await localDataSource.getLastTradePoints(
          category,
          direction,
        );
        return Right(localData);
      } catch (e) {
        locator<LogService>().logError(
          ErrorModel(
            tag: 'DataProvider getTradePoints Cache',
            message: e.toString(),
            timestamp: DateTime.now().millisecondsSinceEpoch,
            isUploaded: false,
          ),
        );
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<WinItem>>> getWinPoints(
      WinPointCategory category,
      WinPointDirection direction,
      bool expired,
      bool outsideGeo,
      List<double> coordinates) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getWinPoints(
            category, direction, expired, outsideGeo, coordinates);
        localDataSource.cacheLastWinPoints(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerFailure catch (e) {
        locator<LogService>().logError(
          ErrorModel(
            tag: 'DataProvider getWinPoints remote',
            message: e.toString(),
            timestamp: DateTime.now().millisecondsSinceEpoch,
            isUploaded: false,
          ),
        );
        return Left(e);
      }
    } else {
      try {
        final localData = await localDataSource.getLastWinPoints(
          category,
          direction,
        );
        return Right(localData);
      } catch (e) {
        locator<LogService>().logError(
          ErrorModel(
            tag: 'DataProvider getWinPoints Cache',
            message: e.toString(),
            timestamp: DateTime.now().millisecondsSinceEpoch,
            isUploaded: false,
          ),
        );
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, SearchDtoModel>> search(
    String text,
  ) async {
    try {
      final remoteData = await remoteDataSource.search(text);
      return Right(remoteData);
    } on ServerFailure catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider search',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> sendMail(
    String name,
    String email,
    String content,
    bool isDebug,
  ) async {
    try {
      final remoteData =
          await remoteDataSource.sendMail(name, email, content, isDebug);
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, String>> getPoints() async {
    try {
      final remoteData = await remoteDataSource.getPoints();
      return Right(remoteData);
    } on ServerFailure catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider getPoints',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      return Left(e);
    } on CacheFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, String>> tradePoints(int perkId, int amount) async {
    try {
      final remoteData = await remoteDataSource.tradePoints(perkId, amount);
      return Right(remoteData);
    } on ServerFailure catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider tradePoints',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<MyTradeModel>>> getMyTrades() async {
    try {
      final remoteData = await remoteDataSource.getMyTrades();
      return Right(remoteData);
    } on ServerFailure catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider getMyTrades',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<ProductConsumedModel>>> getProductsConsumed(
      MyProductOrder order, MyProductDirection direction) async {
    try {
      final remoteData =
          await remoteDataSource.getProductsConsumed(order, direction);
      return Right(remoteData);
    } on ServerFailure catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider getProductsConsumed',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(String password) async {
    try {
      final remoteData = await remoteDataSource.deleteAccount(password);
      return Right(remoteData);
    } on ServerFailure catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider deleteAccount',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, FoodFactModel>> getFoodFact(String barcode) async {
    try {
      final remoteData = await remoteDataSource.getFoodFact(barcode);
      return Right(remoteData);
    } on ServerFailure catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider getFoodFact',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> isVideoAlreadyUploaded(
      String path, String creationDate) async {
    try {
      final remoteData =
          await remoteDataSource.isVideoAlreadyUploaded(path, creationDate);
      return Right(remoteData);
    } on ServerFailure catch (e) {
      locator<LogService>().logError(
        ErrorModel(
          tag: 'DataProvider isVideoAlreadyUploaded',
          message: e.toString(),
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isUploaded: false,
        ),
      );
      return Left(e);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<WinItem>>> getWinPointsFeatured() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getWinPointsFeatured();
        //localDataSource.cacheLastWinPointsFeatured(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerFailure catch (e) {
        locator<LogService>().logError(
          ErrorModel(
            tag: 'DataProvider getWinPointsFeatured',
            message: e.toString(),
            timestamp: DateTime.now().millisecondsSinceEpoch,
            isUploaded: false,
          ),
        );
        return Left(e);
      }
    } else {
      try {
        /*final localData = await localDataSource.getLastWinPoints(
          category,
          direction,
        );*/
        //return Right(localData);
        return Left(CacheFailure());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> addSeenWinPoint(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.addSeenWinPoint(id);
        //localDataSource.cacheLastWinPointsFeatured(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerFailure catch (e) {
        locator<LogService>().logError(
          ErrorModel(
            tag: 'DataProvider addSeenWinPoint',
            message: e.toString(),
            timestamp: DateTime.now().millisecondsSinceEpoch,
            isUploaded: false,
          ),
        );
        return Left(e);
      }
    } else {
      try {
        /*final localData = await localDataSource.getLastWinPoints(
          category,
          direction,
        );*/
        //return Right(localData);
        return Left(CacheFailure());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> addSeenTradePoint(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.addSeenTradePoint(id);
        //localDataSource.cacheLastWinPointsFeatured(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerFailure catch (e) {
        locator<LogService>().logError(
          ErrorModel(
            tag: 'DataProvider addSeenTradePoint',
            message: e.toString(),
            timestamp: DateTime.now().millisecondsSinceEpoch,
            isUploaded: false,
          ),
        );
        return Left(e);
      }
    } else {
      try {
        /*final localData = await localDataSource.getLastWinPoints(
          category,
          direction,
        );*/
        //return Right(localData);
        return Left(CacheFailure());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<TradeItem>>> getTradePointsFeatured() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getTradePointsFeatured();
        //localDataSource.cacheLastWinPointsFeatured(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerFailure catch (e) {
        locator<LogService>().logError(
          ErrorModel(
            tag: 'DataProvider getTradePointsFeatured',
            message: e.toString(),
            timestamp: DateTime.now().millisecondsSinceEpoch,
            isUploaded: false,
          ),
        );
        return Left(e);
      }
    } else {
      try {
        /*final localData = await localDataSource.getLastWinPoints(
          category,
          direction,
        );*/
        //return Right(localData);
        return Left(CacheFailure());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> saveFCMToken(String token) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.saveFCMToken(token);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerFailure catch (e) {
        locator<LogService>().logError(
          ErrorModel(
            tag: 'DataProvider saveFCMToken',
            message: e.toString(),
            timestamp: DateTime.now().millisecondsSinceEpoch,
            isUploaded: false,
          ),
        );
        return Left(e);
      }
    } else {
      try {
        return Left(CacheFailure());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, SearchDto>> getFeatured(
      double lat, double long) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getFeatured(lat, long);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerFailure catch (e) {
        locator<LogService>().logError(
          ErrorModel(
            tag: 'DataProvider getFeatured',
            message: e.toString(),
            timestamp: DateTime.now().millisecondsSinceEpoch,
            isUploaded: false,
          ),
        );
        return Left(e);
      }
    } else {
      try {
        /*final localData = await localDataSource.getLastWinPoints(
          category,
          direction,
        );*/
        //return Right(localData);
        return Left(CacheFailure());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, PrivacyModel>> getPrivacy() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getPrivacy();
        await localDataSource.setPrivacy(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerFailure catch (e) {
        locator<LogService>().logError(
          ErrorModel(
            tag: 'DataProvider setPrivacy',
            message: e.toString(),
            timestamp: DateTime.now().millisecondsSinceEpoch,
            isUploaded: false,
          ),
        );
        return Left(e);
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, PrivacyModel>> setPrivacy(PrivacyModel value) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.setPrivacy(value);
        await localDataSource.setPrivacy(value);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerFailure catch (e) {
        locator<LogService>().logError(
          ErrorModel(
            tag: 'DataProvider setPrivacy',
            message: e.toString(),
            timestamp: DateTime.now().millisecondsSinceEpoch,
            isUploaded: false,
          ),
        );
        return Left(e);
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
