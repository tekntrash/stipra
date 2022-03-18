import '../../models/offer_model.dart';
import '../../models/product_model.dart';

abstract class LocalDataSource {
  Future<List<OfferModel>> getLastOffers();

  Future<void> cacheOffers(List<OfferModel> offerModel);

  Future<List<ProductModel>> getLastProducts();

  Future<void> cacheProducts(List<ProductModel> productModel);
}
