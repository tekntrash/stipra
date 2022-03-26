import '../../data/models/offer_model.dart';
import '../../data/models/product_model.dart';

abstract class LocalDataRepository {
  Future<List<OfferModel>> getLastOffers();

  Future<void> cacheOffers(List<OfferModel> offerModel);

  Future<List<ProductModel>> getLastProducts();

  Future<void> cacheProducts(List<ProductModel> productModel);
}
