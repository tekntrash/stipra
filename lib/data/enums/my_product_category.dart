import 'package:get/get.dart';

class _MyProductCategoryExtension {
  static List<String> categories = [
    "All",
    "Discounts",
    "Exclusive Offers",
    "Free trials",
    "Gaming",
    "Gift Cards",
    "Merchandise",
    "Products",
    "Support a Cause",
  ];

  static List<String> orders = [
    "barcode",
    "name",
    "date",
  ];
}

enum MyProductCategory {
  All,
  Discounts,
  ExclusiveOffers,
  FreeTrials,
  Gaming,
  GiftCards,
  Merchandise,
  Products,
  SupportACause,
}

enum MyProductOrder {
  barcode,
  label,
  datetimetaken,
}

enum MyProductDirection {
  asc,
  desc,
}

extension MyProductCategoryExtension on MyProductCategory {
  String get getCategoryName {
    return _MyProductCategoryExtension.categories[this.index];
  }
}

extension MyProductOrderExtension on MyProductOrder {
  String get getOrderName {
    return 'my_earnings_order_type_${name.toLowerCase()}'.tr;
    //return _MyProductCategoryExtension.orders[this.index];
  }
}
