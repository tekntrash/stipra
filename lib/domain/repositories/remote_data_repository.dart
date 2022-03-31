import 'package:stipra/domain/entities/barcode_timestamp.dart';

import '../../data/models/offer_model.dart';
import '../../data/models/product_model.dart';

abstract class RemoteDataRepository {
  Future<List<OfferModel>> getOffers();

  Future<List<ProductModel>> getProducts();

  Future<void> sendBarcode(
      String barcode, String videoName, double latitude, double longitude);

  Future<bool> sendScannedVideo(String videoPath);
}
