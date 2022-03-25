import 'package:dartz/dartz.dart';
import 'package:stacked/stacked.dart';

import '../../../data/models/offer_model.dart';
import '../../../data/models/product_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';

class PerksViewModel extends BaseViewModel {
  late bool isInited;
  late List<ProductModel> products;
  late List<OfferModel> offers;
  init() async {
    offers = [];
    products = [];
    isInited = false;
    await Future.wait([
      getProducts(),
      getOffers(),
    ]);
    isInited = true;
    notifyListeners();
  }

  Future getProducts() async {
    final data = await locator<DataRepository>().getProducts();
    if (data is Right) {
      products = (data as Right).value;
    }
  }

  Future getOffers() async {
    final data = await locator<DataRepository>().getOffers();
    if (data is Right) {
      offers = (data as Right).value;
    }
  }
}
