import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/data/enums/my_product_category.dart';
import 'package:stipra/data/models/product_consumed_model.dart';

import '../../../data/models/my_trade_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';

class MyProductsViewModel extends BaseViewModel {
  late bool isInited;
  late List<ProductConsumedModel> productsConsumed;
  late MyProductOrder selectedOrder;
  late MyProductDirection selectedDirection;

  late bool isLoading;
  init() async {
    productsConsumed = [];
    isInited = false;
    isLoading = true;
    selectedOrder = MyProductOrder.barcode;
    selectedDirection = MyProductDirection.desc;
    await Future.wait([
      getProductsConsumed(),
    ]);
    isInited = true;
    isLoading = false;
    notifyListeners();
  }

  /// Change category then get new perks from backend with new category
  Future<void> changeOrder(MyProductOrder order) async {
    selectedOrder = order;
    isLoading = true;
    notifyListeners();
    await getProductsConsumed();
    isLoading = false;
    notifyListeners();
  }

  /// Change direction then get new perks from backend with new direction
  Future<void> changeDirection(MyProductDirection direction) async {
    selectedDirection = direction;
    isLoading = true;
    notifyListeners();
    await getProductsConsumed();
    isLoading = false;
    notifyListeners();
  }

  Future getProductsConsumed() async {
    final data = await locator<DataRepository>().getProductsConsumed(
      selectedOrder,
      selectedDirection,
    );
    if (data is Right) {
      productsConsumed = (data as Right).value;
    } else {
      productsConsumed = [];
    }
    log('Trade items: $productsConsumed');
  }
}
