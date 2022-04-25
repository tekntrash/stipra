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

  UserModel getUser();

  late Stream<UserModel> userStream;

  Future<void> cacheUser(UserModel userModel);

  Future<bool> isFirstTimeLogin();
}
