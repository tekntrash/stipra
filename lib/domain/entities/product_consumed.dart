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
  final dynamic points;
  final dynamic totalproduct;
  final String? dateTaken;
  final dynamic barcode;

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
