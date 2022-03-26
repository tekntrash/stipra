import '../../data/models/offer_model.dart';
import '../../data/models/product_model.dart';

abstract class RemoteDataRepository {
  Future<List<OfferModel>> getOffers();

  Future<List<ProductModel>> getProducts();

  Future<void> sendBarcode(String barcode);
}
