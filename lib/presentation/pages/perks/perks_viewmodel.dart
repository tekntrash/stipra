import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/data/enums/trade_point_category.dart';
import 'package:stipra/data/models/trade_item_model.dart';

import '../../../core/services/scanned_video_service.dart';
import '../../../data/models/search_dto_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';

/// PerksViewModel uses for get perks from backend

class PerksViewModel extends BaseViewModel {
  late bool isInited;
  late List<TradeItemModel> tradeItems;
  late SearchDtoModel featuredItems;
  late TradePointCategory selectedCategory;
  late TradePointDirection selectedDirection;
  late bool selectedExpire;
  late bool isLoading;
  late bool isFeaturedClosed;

  /// Initialize the view model with the default category and direction
  init() async {
    tradeItems = [];
    featuredItems = SearchDtoModel(tradeItems: [], winItems: []);
    isInited = false;
    isLoading = true;
    selectedExpire = false;
    isFeaturedClosed = false;
    selectedCategory = TradePointCategory.All;
    selectedDirection = TradePointDirection.asc;
    await Future.wait([
      getTradePoints(),
      getFeaturedItems(),
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

  Future getFeaturedItems() async {
    final location = await locator<ScannedVideoService>()
        .getLocationWithPermRequest(request: false);
    final data = await locator<DataRepository>().getFeatured(50, -6);
    if (data is Right) {
      log('Featured items: ${(data as Right).value}');
      featuredItems = (data as Right).value as SearchDtoModel;
      if (featuredItems.tradeItems?.length == 0 &&
          featuredItems.winItems?.length == 0) {
        isFeaturedClosed = true;
      }
    } else {
      featuredItems = SearchDtoModel(tradeItems: [], winItems: []);
    }
  }

  void closeFeatured() {
    isFeaturedClosed = true;
    notifyListeners();
  }
}
