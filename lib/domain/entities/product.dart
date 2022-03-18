import 'package:equatable/equatable.dart';

class Product extends Equatable {
  Product({
    this.title,
    this.desc,
    this.awardPoint,
    this.image,
    this.startDate,
    this.endDate,
    this.similarProducts,
  });

  final String? title;
  final String? desc;
  final int? awardPoint;
  final String? image;
  final String? startDate;
  final String? endDate;
  final List<Product>? similarProducts;

  @override
  List<Object?> get props =>
      [title, desc, awardPoint, image, startDate, endDate, similarProducts];
}
