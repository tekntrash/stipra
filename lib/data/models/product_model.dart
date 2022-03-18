import 'dart:convert';

import 'package:stipra/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    this.title,
    this.desc,
    this.awardPoint,
    this.image,
    this.startDate,
    this.endDate,
    this.similarProducts,
  }) : super(
          title: title,
          desc: desc,
          awardPoint: awardPoint,
          image: image,
          startDate: startDate,
          endDate: endDate,
          similarProducts: similarProducts,
        );

  final String? title;
  final String? desc;
  final int? awardPoint;
  final String? image;
  final String? startDate;
  final String? endDate;
  final List<ProductModel>? similarProducts;

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        title: json["title"] == null ? null : json["title"],
        desc: json["desc"] == null ? null : json["desc"],
        awardPoint: json["award_point"] == null ? null : json["award_point"],
        image: json["image"] == null ? null : json["image"],
        startDate: json["start_date"] == null ? null : json["start_date"],
        endDate: json["end_date"] == null ? null : json["end_date"],
        similarProducts: json["similar_products"] == null
            ? null
            : List<ProductModel>.from(
                json["similar_products"].map((x) => ProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "desc": desc == null ? null : desc,
        "award_point": awardPoint == null ? null : awardPoint,
        "image": image == null ? null : image,
        "start_date": startDate == null ? null : startDate,
        "end_date": endDate == null ? null : endDate,
        "similar_products": similarProducts == null
            ? null
            : List<dynamic>.from(similarProducts?.map((x) => x.toJson()) ?? []),
      };
}
