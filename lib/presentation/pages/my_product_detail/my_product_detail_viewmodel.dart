import 'package:stacked/stacked.dart';

class MyProductsDetailViewModel extends BaseViewModel {
  late bool isInited;

  Future<void> init() async {
    isInited = false;

    isInited = true;
    notifyListeners();
  }
}
