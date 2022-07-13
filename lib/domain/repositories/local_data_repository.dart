import 'package:stipra/data/enums/trade_point_category.dart';
import 'package:stipra/data/enums/win_point_category.dart';
import 'package:stipra/data/models/privacy_model.dart';
import 'package:stipra/data/models/trade_item_model.dart';
import 'package:stipra/data/models/win_item_model.dart';

import '../../data/models/error_model.dart';
import '../../data/models/scanned_video_model.dart';
import '../../data/models/user_model.dart';

import '../../data/models/offer_model.dart';
import '../../data/models/product_model.dart';

abstract class LocalDataRepository {
  Future<List<OfferModel>> getLastOffers();

  Future<void> cacheOffers(List<OfferModel> offerModel);

  Future<List<ProductModel>> getLastProducts();

  Future<void> cacheProducts(List<ProductModel> productModel);

  Future<void> saveScannedVideo(ScannedVideoModel scannedVideoModel);

  Future<void> updateIsUploaded(String path, bool isUploaded);

  Future<List<ScannedVideoModel>> getScannedVideos();

  Future<void> deleteScannedVideo(ScannedVideoModel scannedVideoModel);

  UserModel getUser();

  late Stream<UserModel> userStream;

  Future<void> cacheUser(UserModel userModel);

  Future<bool> isFirstTimeLogin();

  Future<List<WinItemModel>> getLastWinPoints(
    WinPointCategory category,
    WinPointDirection direction,
  );

  Future<void> cacheLastWinPoints(
    List<WinItemModel> winItems,
  );

  Future<List<TradeItemModel>> getLastTradePoints(
    TradePointCategory category,
    TradePointDirection direction,
  );

  Future<void> cacheLastTradePoints(
    List<TradeItemModel> tradeItems,
  );

  Future<void> logError(ErrorModel errorModel);
  Future<List<ErrorModel>> getLogs();

  PrivacyModel getPrivacy();
  Future<void> setPrivacy(PrivacyModel privacyModel);
}
