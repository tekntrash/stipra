import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/data/enums/trade_point_category.dart';
import 'package:stipra/data/models/trade_item_model.dart';

import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';

class PerksViewModel extends BaseViewModel {
  late bool isInited;
  late List<TradeItemModel> tradeItems;
  late TradePointCategory selectedCategory;
  late TradePointDirection selectedDirection;
  late bool selectedExpire;
  late bool isLoading;
  init() async {
    tradeItems = [];
    isInited = false;
    isLoading = true;
    selectedExpire = false;
    selectedCategory = TradePointCategory.All;
    selectedDirection = TradePointDirection.asc;
    await Future.wait([
      getTradePoints(),
    ]);
    isInited = true;
    notifyListeners();
  }

  Future<void> changeCategory(TradePointCategory category) async {
    selectedCategory = category;
    isLoading = true;
    notifyListeners();
    await getTradePoints();
    isLoading = false;
    notifyListeners();
  }

  Future<void> changeDirection(TradePointDirection direction) async {
    selectedDirection = direction;
    isLoading = true;
    notifyListeners();
    await getTradePoints();
    isLoading = false;
    notifyListeners();
  }

  Future<void> onShowExpiredChanged(bool status) async {
    selectedExpire = status;
    isLoading = true;
    notifyListeners();
    await getTradePoints();
    isLoading = false;
    notifyListeners();
  }

  Future getTradePoints() async {
    final data = await locator<DataRepository>().getTradePoints(
      selectedCategory,
      selectedDirection,
      selectedExpire,
    );
    if (data is Right) {
      tradeItems = (data as Right).value;
    }
    log('Trade items: $tradeItems');
  }
}
