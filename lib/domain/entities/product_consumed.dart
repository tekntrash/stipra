import 'package:equatable/equatable.dart';

class ProductConsumed extends Equatable {
  ProductConsumed({
    this.label,
    this.latitude,
    this.longitude,
    this.base64,
    this.bincolor,
    this.points,
    this.totalproduct,
    this.dateTaken,
    this.barcode,
  });

  final String? label;
  final String? latitude;
  final String? longitude;
  final String? base64;
  final String? bincolor;
  final String? points;
  final String? totalproduct;
  final String? dateTaken;
  final String? barcode;

  @override
  List<Object?> get props => [
        label,
        latitude,
        longitude,
        base64,
        bincolor,
        points,
        totalproduct,
        dateTaken,
        barcode,
      ];
}