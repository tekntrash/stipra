class _WinPointCategoryExtension {
  static List<String> categories = [
    "All",
    "Automotive",
    "Baby",
    "Books",
    "Camera & Photo",
    "CDs & Vinyl",
    "Clothing",
    "Computers & Accessories",
    "DVD & Blu-ray",
    "Electronics & Mobiles",
    "Fashion",
    "Garden & Outdoors",
    "Groceries and Food",
    "Health & Personal Care",
    "Home & Kitchen",
    "Industrial & Scientific",
    "Jewellery",
    "Large Appliances",
    "Lighting",
    "Luggage",
    "Magazines",
    "Musical Instruments & DJ Equipment",
    "Office Products",
    "PC & Video Games",
    "Perfume & Cosmetic",
    "Pet Supplies",
    "Shoes & Handbags",
    "Sports",
    "Toys & Games",
    "Watches",
  ];
}

enum WinPointCategory {
  All,
  Automotive,
  Baby,
  Books,
  Camera_Photo,
  CDs_Vinyl,
  Clothing,
  Computers_Accessories,
  DVD_Blu_ray,
  Electronics_Mobiles,
  Fashion,
  Garden_Outdoors,
  Groceries_Food,
  Health_Personal_Care,
  Home_Kitchen,
  Industrial_Scientific,
  Jewellery,
  Large_Appliances,
  Lighting,
  Luggage,
  Magazines,
  Musical_Instruments_DJ_Equipment,
  Office_Products,
  PC_Video_Games,
  Perfume_Cosmetic,
  Pet_Supplies,
  Shoes_Handbags,
  Sports,
  Toys_Games,
  Watches,
}

enum WinPointDirection {
  asc,
  desc,
}

extension WinPointCategoryExtension on WinPointCategory {
  String get getCategoryName {
    return _WinPointCategoryExtension.categories[this.index];
  }
}
