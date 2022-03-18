import 'package:stipra/data/datasources/remote/remote_data_source.dart';

import '../../models/offer_model.dart';
import '../../models/product_model.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<List<OfferModel>> getOffers() {
    // TODO: implement getOffers
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }
}
