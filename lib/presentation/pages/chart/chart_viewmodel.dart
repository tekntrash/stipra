import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/data/models/food_fact_model.dart';

import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';

class ChartViewModel extends BaseViewModel {
  final String barcode;
  ChartViewModel(this.barcode);

  late bool isInited;
  late bool isLoading;
  late FoodFactModel foodFact;
  late bool isFoodExists;

  init() async {
    isInited = false;
    isLoading = true;
    await Future.wait([
      getFoodFact(),
    ]);
    isInited = true;
    isLoading = false;
    notifyListeners();
  }

  Future getFoodFact() async {
    final data = await locator<DataRepository>().getFoodFact(
      barcode,
    );
    if (data is Right) {
      foodFact = (data as Right).value;
    } else {
      foodFact = FoodFactModel();
    }
    if (foodFact.status != 1) {
      isFoodExists = false;
    } else {
      isFoodExists = true;
    }
    getCategories();
  }

  getCategories() {
    log('Allergens: ${foodFact.toJson()}');
  }
}
