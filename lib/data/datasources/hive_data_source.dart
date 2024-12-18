import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stipra/data/enums/trade_point_category.dart';
import 'package:stipra/data/models/privacy_model.dart';
import 'package:stipra/data/models/trade_item_model.dart';
import 'package:stipra/data/models/win_item_model.dart';
import 'package:stipra/data/enums/win_point_category.dart';
import '../models/error_model.dart';
import '../models/user_model.dart';

import '../../core/errors/exception.dart';
import '../../domain/repositories/local_data_repository.dart';
import '../models/barcode_timestamp_model.dart';
import '../models/offer_model.dart';
import '../models/product_model.dart';
import '../models/scanned_video_model.dart';

/// This is local storage data source
/// It uses [Hive] to store data
/// It implements [LocalDataRepository] interface

class HiveDataSource implements LocalDataRepository {
  /// These are the keys for the hive box names
  final _scannedVideosBoxName = 'scanned_videos';
  final _userBoxName = 'users';
  final _winPointBoxName = 'win_points';
  final _tradePointBoxName = 'trade_points';
  final _errorLogsBoxName = 'error_logs';
  final _privacyBoxNmae = 'privacy';

  @override
  late Stream<UserModel> userStream;

  /// Initialize the hive data source
  /// Register data types and opens the hive box for use
  /// This method is called in [InjectionContainer]
  /// If there is no user in the hive box, it will create a new one
  /// And start listening to the user stream that can be used in UI to change the UI immediately
  Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(BarcodeTimeStampModelAdapter());
    Hive.registerAdapter(ScannedVideoModelAdapter());
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(WinItemModelAdapter());
    Hive.registerAdapter(TradeItemModelAdapter());
    Hive.registerAdapter(ErrorModelAdapter());
    Hive.registerAdapter(PrivacyModelAdapter());

    await openBox<ScannedVideoModel>(_scannedVideosBoxName);
    await openBox<UserModel>(_userBoxName);
    await openBox<WinItemModel>(_winPointBoxName);
    await openBox<TradeItemModel>(_tradePointBoxName);
    await openBox<ErrorModel>(_errorLogsBoxName);
    await openBox<PrivacyModel>(_privacyBoxNmae);

    if (Hive.box<UserModel>(_userBoxName).values.length <= 0) {
      await cacheUser(UserModel());
    }
    userStream = Hive.box<UserModel>(_userBoxName).watch().map((box) {
      log('userStream: ${box.value}');
      return box.value;
    });
  }

  Future<void> openBox<T>(String boxName) async {
    try {
      await Hive.openBox<T>(boxName);
    } catch (e) {
      var box = Hive.box<T>(boxName);
      await box.clear();
      await openBox<T>(boxName);
    }
  }

  /// Cache the video datas to the local storage with hive
  @override
  Future<void> saveScannedVideo(ScannedVideoModel scannedVideoModel) async {
    var box = Hive.box<ScannedVideoModel>(_scannedVideosBoxName);

    await box.add(scannedVideoModel);
  }

  /// Delete the videos from the local storage with hive
  Future<void> deleteAllScannedVideos() async {
    var box = Hive.box<ScannedVideoModel>(_scannedVideosBoxName);
    final List<ScannedVideoModel> _scannedVideos =
        List.from(box.values.toList());
    for (ScannedVideoModel scannedVideo in _scannedVideos) {
      scannedVideo.delete();
    }
  }

  /// Update [isUploaded] parameter of the scanned video in the local storage with hive
  Future<void> updateIsUploaded(String videoPath, bool isUploaded) async {
    var box = Hive.box<ScannedVideoModel>(_scannedVideosBoxName);
    final List<ScannedVideoModel> _scannedVideos =
        List.from(box.values.toList());
    for (ScannedVideoModel scannedVideo in _scannedVideos) {
      if (videoPath == scannedVideo.videoPath) {
        scannedVideo.isUploaded = isUploaded;
        await scannedVideo.save();
        return;
      }
    }
  }

  /// Get all the scanned videos from the local storage
  Future<List<ScannedVideoModel>> getScannedVideos() async {
    var box = Hive.box<ScannedVideoModel>(_scannedVideosBoxName);

    if (box.values.length > 0)
      return box.values.toList();
    else
      return [];
  }

  /// Not implemented yet
  @override
  Future<void> cacheOffers(List<OfferModel> offerModel) {
    // TODO: implement cacheOffers
    throw UnimplementedError();
  }

  /// Not implemented yet
  @override
  Future<void> cacheProducts(List<ProductModel> productModel) {
    // TODO: implement cacheProducts
    throw UnimplementedError();
  }

  /// Not implemented yet
  @override
  Future<List<OfferModel>> getLastOffers() async {
    throw UnimplementedError();
  }

  /// Not implemented yet
  Future<List<ProductModel>> getLastProducts() async {
    /*final String? jsonString =
        await rootBundle.loadString('test/fixtures/product_list.json');

    if (jsonString != null) {
      final data = await json.decode(jsonString);
      return Future.value(
          List<ProductModel>.from(data.map((x) => ProductModel.fromJson(x))));
    } else {
      throw CacheException();
    }*/
    throw UnimplementedError();
  }

  /// Cache the user to the local storage with hive
  @override
  Future<void> cacheUser(UserModel userModel) async {
    var box = Hive.box<UserModel>(_userBoxName);

    if (box.length > 0) {
      box.values.first.updateFromJson(userModel.toJson());
      await box.values.first.save();
      return;
    }

    await box.add(userModel);
  }

  /// Get the user from the local storage
  @override
  UserModel getUser() {
    var box = Hive.box<UserModel>(_userBoxName);
    return box.values.first;
  }

  /// Control the user data from local storage if it is null or not
  /// If null it will return true and will set lastLogin to [DateTime.now]
  @override
  Future<bool> isFirstTimeLogin() async {
    var user = getUser();
    log('isFirstTimeLogin user: ${user}');
    if (user.lastLoginTime == null) {
      user.lastLoginTime = DateTime.now();
      log('isFirstTimeLogin user: ${getUser()}');
      await getUser().save();
      log('isFirstTimeLogin user: ${getUser()}');
      return true;
    }

    return false;
  }

  @override
  Future<void> deleteScannedVideo(ScannedVideoModel scannedVideoModel) async {
    var box = Hive.box<ScannedVideoModel>(_scannedVideosBoxName);
    final List<ScannedVideoModel> _scannedVideos =
        List.from(box.values.toList());
    for (ScannedVideoModel scannedVideo in _scannedVideos) {
      if (scannedVideo == scannedVideoModel) {
        await scannedVideo.delete();
        return;
      }
    }
  }

  @override
  Future<void> cacheLastWinPoints(List<WinItemModel> winItems) async {
    var box = Hive.box<WinItemModel>(_winPointBoxName);
    await box.clear();
    await box.addAll(winItems);
  }

  @override
  Future<List<WinItemModel>> getLastWinPoints(
    WinPointCategory category,
    WinPointDirection direction,
  ) async {
    var box = Hive.box<WinItemModel>(_winPointBoxName);
    return box.values.toList();
    //Todo need backend support
    /*if (category == WinPointCategory.All) {
      return box.values.toList();
    }else{
      return box.values.where((element) => element.)
    }*/
  }

  @override
  Future<void> cacheLastTradePoints(List<TradeItemModel> tradeItems) async {
    var box = Hive.box<TradeItemModel>(_tradePointBoxName);
    await box.clear();
    await box.addAll(tradeItems);
  }

  @override
  Future<List<TradeItemModel>> getLastTradePoints(
    TradePointCategory category,
    TradePointDirection direction,
  ) async {
    var box = Hive.box<TradeItemModel>(_tradePointBoxName);
    return box.values.toList();
    //Todo need backend support
    /*if (category == TradePointCategory.All) {
      return box.values.toList();
    }else{
      return box.values.where((element) => element.)
    }*/
  }

  @override
  Future<void> logError(ErrorModel errorModel) async {
    var box = Hive.box<ErrorModel>(_errorLogsBoxName);
    await box.add(errorModel);
  }

  @override
  Future<List<ErrorModel>> getLogs() async {
    var box = Hive.box<ErrorModel>(_errorLogsBoxName);
    return box.values.toList();
  }

  @override
  PrivacyModel getPrivacy() {
    var box = Hive.box<PrivacyModel>(_privacyBoxNmae);
    return box.values.first;
  }

  @override
  Future<void> setPrivacy(PrivacyModel privacyModel) async {
    var box = Hive.box<PrivacyModel>(_privacyBoxNmae);

    if (box.length > 0) {
      box.values.first.updateFromJson(privacyModel.toJson());
      await box.values.first.save();
      return;
    }

    await box.add(privacyModel);
  }
}
