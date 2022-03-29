import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:stipra/core/errors/exception.dart';
import 'package:stipra/data/models/scanned_video_model.dart';
import 'package:stipra/domain/repositories/local_data_repository.dart';

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
}
