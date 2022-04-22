import 'package:dartz/dartz.dart';
import 'package:stipra/data/models/search_dto_model.dart';
import 'package:stipra/domain/entities/win_item.dart';
import '../../domain/entities/trade_item.dart';
import '../enums/change_email_action_type.dart';
import '../enums/change_password_action_type.dart';
import '../enums/change_profile_action_type.dart';
import '../enums/reset_password_action_type.dart';
import '../enums/sms_action_type.dart';
import '../enums/win_point_category.dart';
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
  Future<Either<Failure, void>> sendBarcode(String barcode, String videoName,
      double latitude, double longitude) async {
    try {
      final remoteData = await remoteDataSource.sendBarcode(
          barcode, videoName, latitude, longitude);
      return Right(remoteData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> sendScannedVideo(
      String videoPath, double latitude, double longitude) async {
    try {
      final remoteData = await remoteDataSource.sendScannedVideo(
          videoPath, latitude, longitude);
      return Right(remoteData);
    } on ServerException {
      return Left(ServerFailure());
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
  Future<Either<Failure, void>> callPythonForScannedVideo(
      String videoPath, double latitude, double longitude) async {
    try {
      final remoteData = await remoteDataSource.sendScannedVideo(
          videoPath, latitude, longitude);
      return Right(remoteData);
    } on ServerException {
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
    } on ServerException {
      return Left(ServerFailure());
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
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<TradeItem>>> getTradePoints() async {
    try {
      final remoteData = await remoteDataSource.getTradePoints();
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<WinItem>>> getWinPoints(
      WinPointCategory category,
      WinPointDirection direction,
      bool expired,
      List<double> coordinates) async {
    try {
      final remoteData = await remoteDataSource.getWinPoints(
          category, direction, expired, coordinates);
      return Right(remoteData);
    } on ServerFailure catch (e) {
      return Left(e);
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
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> sendMail(
    String name,
    String email,
    String content,
  ) async {
    try {
      final remoteData = await remoteDataSource.sendMail(name, email, content);
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
      return Left(e);
    }
  }
}
