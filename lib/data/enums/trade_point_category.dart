import 'package:get/get.dart';

class _TradePointCategoryExtension {
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
}

enum TradePointCategory {
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

enum TradePointDirection {
  asc,
  desc,
}

extension TradePointCategoryExtension on TradePointCategory {
  String get getCategoryName {
    return 'redeem_page_category_${name.toLowerCase()}'.tr;
    //return _TradePointCategoryExtension.categories[this.index];
  }
}
