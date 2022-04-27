import 'package:stacked/stacked.dart';

class PerkDetailViewModel extends BaseViewModel {
  late bool isInited;

  Future<void> init() async {
    isInited = false;

    isInited = true;
    notifyListeners();
  }
}
