import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/data/models/trade_item_model.dart';

import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';

class PerksViewModel extends BaseViewModel {
  late bool isInited;
  late List<TradeItemModel> tradeItems;
  init() async {
    tradeItems = [];
    isInited = false;
    await Future.wait([
      getTradePoints(),
    ]);
    isInited = true;
    notifyListeners();
  }

  Future getTradePoints() async {
    final data = await locator<DataRepository>().getTradePoints();
    if (data is Right) {
      tradeItems = (data as Right).value;
    }
    log('Trade items: $tradeItems');
  }
}
