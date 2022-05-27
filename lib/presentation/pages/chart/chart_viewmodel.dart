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
  late List<_NutritionCategory> nutritionCategories;

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
    log('Hiearcayh ${foodFact.product?.ingredientsHierarchy}');
    log('Nutri ${foodFact.product?.toJson()}');
    log('Carbo per100 ${foodFact.product?.nutriments?.carbohydrates100G}');
    log('Carbo unit ${foodFact.product?.nutriments?.carbohydratesUnit}');
    log('Carbo value ${foodFact.product?.nutriments?.carbohydratesValue}');
    log('En ${foodFact.product?.ingredientsTextEn}');
    setNutritions();
  }

  List<_NutritionCategory> setNutritions() {
    nutritionCategories = <_NutritionCategory>[];
    if (foodFact.product?.nutriments?.proteins100G != null)
      nutritionCategories.add(_NutritionCategory(
        name: 'Protein',
        value: foodFact.product!.nutriments!.proteins100G!,
        dailyReference: 50,
        type: 'g',
      ));
    if (foodFact.product?.nutriments?.carbohydrates100G != null)
      nutritionCategories.add(_NutritionCategory(
        name: 'Carbohydrate',
        value: foodFact.product!.nutriments!.carbohydrates100G!,
        dailyReference: 275,
        type: 'g',
      ));
    if (foodFact.product?.nutriments?.energyKcal100G != null)
      nutritionCategories.add(_NutritionCategory(
        name: 'Energy',
        value: foodFact.product!.nutriments!.energyKcal100G!,
        dailyReference: 2000,
        type: 'kcal',
      ));
    if (foodFact.product?.nutriments?.fat100G != null)
      nutritionCategories.add(_NutritionCategory(
        name: 'Fat',
        value: foodFact.product!.nutriments!.fat100G!,
        dailyReference: 78,
        type: 'g',
      ));
    if (foodFact.product?.nutriments?.salt100G != null)
      nutritionCategories.add(_NutritionCategory(
        name: 'Salt',
        value: foodFact.product!.nutriments!.salt100G!,
        dailyReference: 6,
        type: 'g',
      ));
    if (foodFact.product?.nutriments?.saturatedFat100G != null)
      nutritionCategories.add(_NutritionCategory(
        name: 'Saturated fat',
        value: foodFact.product!.nutriments!.saturatedFat100G!,
        dailyReference: 20,
        type: 'g',
      ));
    if (foodFact.product?.nutriments?.sodium100G != null)
      nutritionCategories.add(_NutritionCategory(
        name: 'Sodium',
        value: foodFact.product!.nutriments!.sodium100G!,
        dailyReference: 2.3,
        type: 'g',
      ));
    if (foodFact.product?.nutriments?.sugars100G != null)
      nutritionCategories.add(_NutritionCategory(
        name: 'Sugars',
        value: foodFact.product!.nutriments!.sugars100G!,
        dailyReference: 50,
        type: 'g',
      ));
    return nutritionCategories;
  }
}

class _NutritionCategory {
  final String name;
  final num value;
  final num dailyReference;
  final String type;
  _NutritionCategory({
    required this.name,
    required this.value,
    required this.dailyReference,
    required this.type,
  });
}
