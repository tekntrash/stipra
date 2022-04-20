import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';

import '../../core/errors/exception.dart';
import '../../domain/repositories/local_data_repository.dart';
import '../models/barcode_timestamp_model.dart';
import '../models/offer_model.dart';
import '../models/product_model.dart';
import '../models/scanned_video_model.dart';

class HiveDataSource implements LocalDataRepository {
  final _scannedVideosBoxName = 'scanned_videos';
  final _userBoxName = 'users';
  Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(BarcodeTimeStampModelAdapter());
    Hive.registerAdapter(ScannedVideoModelAdapter());
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<ScannedVideoModel>(_scannedVideosBoxName);
    await Hive.openBox<UserModel>(_userBoxName);
    if (Hive.box<UserModel>(_userBoxName).values.length <= 0) {
      await cacheUser(UserModel());
    }
  }

  @override
  Future<void> saveScannedVideo(ScannedVideoModel scannedVideoModel) async {
    var box = Hive.box<ScannedVideoModel>(_scannedVideosBoxName);

    await box.add(scannedVideoModel);
  }

  Future<void> deleteAllScannedVideos() async {
    var box = Hive.box<ScannedVideoModel>(_scannedVideosBoxName);
    final List<ScannedVideoModel> _scannedVideos =
        List.from(box.values.toList());
    for (ScannedVideoModel scannedVideo in _scannedVideos) {
      scannedVideo.delete();
    }
  }

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

  Future<List<ScannedVideoModel>> getScannedVideos() async {
    var box = Hive.box<ScannedVideoModel>(_scannedVideosBoxName);

    if (box.values.length > 0)
      return box.values.toList();
    else
      return [];
  }

  @override
  Future<void> cacheOffers(List<OfferModel> offerModel) {
    // TODO: implement cacheOffers
    throw UnimplementedError();
  }

  @override
  Future<void> cacheProducts(List<ProductModel> productModel) {
    // TODO: implement cacheProducts
    throw UnimplementedError();
  }

  //! Remove these lines when the app is ready to be used
  //! Change these with the correct data
  @override
  Future<List<OfferModel>> getLastOffers() async {
    final String? jsonString =
        await rootBundle.loadString('test/fixtures/offer_list.json');

    if (jsonString != null) {
      final data = await json.decode(jsonString);
      return Future.value(
          List<OfferModel>.from(data.map((x) => OfferModel.fromJson(x))));
    } else {
      throw CacheException();
    }
  }

  //! Remove these lines when the app is ready to be used
  //! Change these with the correct data
  Future<List<ProductModel>> getLastProducts() async {
    final String? jsonString =
        await rootBundle.loadString('test/fixtures/product_list.json');

    if (jsonString != null) {
      final data = await json.decode(jsonString);
      return Future.value(
          List<ProductModel>.from(data.map((x) => ProductModel.fromJson(x))));
    } else {
      throw CacheException();
    }
  }

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

  @override
  UserModel getUser() {
    var box = Hive.box<UserModel>(_userBoxName);
    return box.values.first;
  }
}
