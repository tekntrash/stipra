enum CardBrands {
  NECTAR,
  STIPRA,
  OTHER,
}

extension CardBrandsExtension on CardBrands {
  String get lowerName => name.toLowerCase();
}
