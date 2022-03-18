import 'package:stacked/stacked.dart';

class TradingOfferDetailViewModel extends BaseViewModel {
  late bool isInited;

  Future<void> init() async {
    isInited = false;

    isInited = true;
    notifyListeners();
  }
}
