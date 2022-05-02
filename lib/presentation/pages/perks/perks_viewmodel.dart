import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/data/enums/trade_point_category.dart';
import 'package:stipra/data/models/trade_item_model.dart';

import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';

/// PerksViewModel uses for get perks from backend

class PerksViewModel extends BaseViewModel {
  late bool isInited;
  late List<TradeItemModel> tradeItems;
  late TradePointCategory selectedCategory;
  late TradePointDirection selectedDirection;
  late bool selectedExpire;
  late bool isLoading;

  /// Initialize the view model with the default category and direction
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
    isLoading = false;
    notifyListeners();
  }

  /// Change category then get new perks from backend with new category
  Future<void> changeCategory(TradePointCategory category) async {
    selectedCategory = category;
    isLoading = true;
    notifyListeners();
    await getTradePoints();
    isLoading = false;
    notifyListeners();
  }

  /// Change direction then get new perks from backend with new direction
  Future<void> changeDirection(TradePointDirection direction) async {
    selectedDirection = direction;
    isLoading = true;
    notifyListeners();
    await getTradePoints();
    isLoading = false;
    notifyListeners();
  }

  //// Change expire then get new perks from backend with new expire
  Future<void> onShowExpiredChanged(bool status) async {
    selectedExpire = status;
    isLoading = true;
    notifyListeners();
    await getTradePoints();
    isLoading = false;
    notifyListeners();
  }

  /// Get trade points from backend
  Future getTradePoints() async {
    final data = await locator<DataRepository>().getTradePoints(
      selectedCategory,
      selectedDirection,
      selectedExpire,
    );
    if (data is Right) {
      tradeItems = (data as Right).value;
    } else {
      tradeItems = [];
    }
    log('Trade items: $tradeItems');
  }
}
