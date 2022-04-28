import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/data/enums/trade_point_category.dart';
import 'package:stipra/data/models/my_trade_model.dart';
import 'package:stipra/data/models/trade_item_model.dart';

import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';

class MyTradesViewModel extends BaseViewModel {
  late bool isInited;
  late List<MyTradeModel> myTrades;
  late bool isLoading;
  init() async {
    myTrades = [];
    isInited = false;
    isLoading = true;
    await Future.wait([
      getMyTrades(),
    ]);
    isInited = true;
    isLoading = false;
    notifyListeners();
  }

  Future getMyTrades() async {
    final data = await locator<DataRepository>().getMyTrades();
    if (data is Right) {
      myTrades = (data as Right).value;
    } else {
      myTrades = [];
    }
    log('Trade items: $myTrades');
  }
}
