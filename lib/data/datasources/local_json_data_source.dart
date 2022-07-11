import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:stipra/data/models/error_model.dart';
import 'package:stipra/data/models/trade_item_model.dart';
import 'package:stipra/data/enums/trade_point_category.dart';
import 'package:stipra/data/models/win_item_model.dart';
import 'package:stipra/data/enums/win_point_category.dart';
import '../../core/errors/exception.dart';
import '../models/scanned_video_model.dart';
import '../models/user_model.dart';
import '../../domain/repositories/local_data_repository.dart';

import '../models/offer_model.dart';
import '../models/product_model.dart';

class JsonLocalDataSource implements LocalDataRepository {
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
  Future<void> cacheOffers(List<OfferModel> offerModel) {
    throw UnimplementedError();
  }

  @override
  Future<void> cacheProducts(List<ProductModel> productModel) {
    throw UnimplementedError();
  }

  @override
  Future<List<ScannedVideoModel>> getScannedVideos() {
    // TODO: implement getScannedVideos
    throw UnimplementedError();
  }

  @override
  Future<void> saveScannedVideo(ScannedVideoModel videoPath) {
    // TODO: implement saveScannedVideo
    throw UnimplementedError();
  }

  @override
  Future<void> updateIsUploaded(String path, bool isUploaded) {
    // TODO: implement updateIsUploaded
    throw UnimplementedError();
  }

  @override
  Future<void> cacheUser(UserModel userModel) {
    // TODO: implement cacheUser
    throw UnimplementedError();
  }

  @override
  UserModel getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  late Stream<UserModel> userStream;

  @override
  Future<bool> isFirstTimeLogin() {
    // TODO: implement isFirstTimeLogin
    throw UnimplementedError();
  }

  @override
  Future<void> deleteScannedVideo(ScannedVideoModel scannedVideoModel) {
    // TODO: implement deleteScannedVideo
    throw UnimplementedError();
  }

  @override
  Future<void> cacheLastWinPoints(
    List<WinItemModel> winItems,
  ) {
    // TODO: implement cacheLastWinPoints
    throw UnimplementedError();
  }

  @override
  Future<List<WinItemModel>> getLastWinPoints(
    WinPointCategory category,
    WinPointDirection direction,
  ) {
    // TODO: implement getLastWinPoints
    throw UnimplementedError();
  }

  @override
  Future<void> cacheLastTradePoints(List<TradeItemModel> tradeItems) {
    // TODO: implement cacheLastTradePoints
    throw UnimplementedError();
  }

  @override
  Future<List<TradeItemModel>> getLastTradePoints(
      TradePointCategory category, TradePointDirection direction) {
    // TODO: implement getLastTradePoints
    throw UnimplementedError();
  }

  @override
  Future<void> logError(ErrorModel errorModel) {
    // TODO: implement logError
    throw UnimplementedError();
  }

  @override
  Future<List<ErrorModel>> getLogs() {
    // TODO: implement getLogs
    throw UnimplementedError();
  }
}
