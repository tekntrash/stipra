import '../../models/offer_model.dart';
import '../../models/product_model.dart';

abstract class RemoteDataSource {
  Future<List<OfferModel>> getOffers();

  Future<List<ProductModel>> getProducts();
}
