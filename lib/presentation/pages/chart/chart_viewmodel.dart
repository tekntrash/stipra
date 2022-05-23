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
    log('Allergens ${foodFact.product?.allergensFromIngredients}');
    log('En ${foodFact.product?.ingredientsTextEn}');
    setNutritions();
  }

  List<_NutritionCategory> setNutritions() {
    nutritionCategories = <_NutritionCategory>[];
    if (foodFact.product?.nutriments?.proteins100G != null)
      nutritionCategories.add(_NutritionCategory(
        name: 'Protein',
        value: foodFact.product!.nutriments!.proteins100G!.toString(),
      ));
    if (foodFact.product?.nutriments?.carbohydrates100G != null)
      nutritionCategories.add(_NutritionCategory(
        name: 'Carbohydrates',
        value: foodFact.product!.nutriments!.carbohydrates100G!.toString(),
      ));
    if (foodFact.product?.nutriments?.energyKcal100G != null)
      nutritionCategories.add(_NutritionCategory(
        name: 'Energy (kcal)',
        value: foodFact.product!.nutriments!.energyKcal100G!.toString(),
      ));
    if (foodFact.product?.nutriments?.fat100G != null)
      nutritionCategories.add(_NutritionCategory(
        name: 'Fat',
        value: foodFact.product!.nutriments!.fat100G!.toString(),
      ));
    if (foodFact.product?.nutriments?.salt100G != null)
      nutritionCategories.add(_NutritionCategory(
        name: 'Salt',
        value: foodFact.product!.nutriments!.salt100G!.toString(),
      ));
    if (foodFact.product?.nutriments?.saturatedFat100G != null)
      nutritionCategories.add(_NutritionCategory(
        name: 'Saturated fat',
        value: foodFact.product!.nutriments!.saturatedFat100G!.toString(),
      ));
    if (foodFact.product?.nutriments?.sodium100G != null)
      nutritionCategories.add(_NutritionCategory(
        name: 'Sodium',
        value: foodFact.product!.nutriments!.sodium100G!.toString(),
      ));
    if (foodFact.product?.nutriments?.sugars100G != null)
      nutritionCategories.add(_NutritionCategory(
        name: 'Sugars',
        value: foodFact.product!.nutriments!.sugars100G!.toString(),
      ));
    return nutritionCategories;
  }
}

class _NutritionCategory {
  final String name;
  final String value;
  _NutritionCategory({required this.name, required this.value});
}
