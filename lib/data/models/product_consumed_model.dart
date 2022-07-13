import 'dart:convert';

import '../../domain/entities/product_consumed.dart';

class ProductConsumedModel extends ProductConsumed {
  ProductConsumedModel({
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
  final String? barcode;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => ProductConsumedModel(
        label: json["label"] == null ? null : json["label"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        base64: json["base64"] == null ? null : json["base64"],
        bincolor: json["bincolor"] == null ? null : json["bincolor"],
        points: json["points"] == null ? null : json["points"],
        totalproduct:
            json["totalproduct"] == null ? null : '${json["totalproduct"]}',
        dateTaken: json["datetaken"] == null ? null : json["datetaken"],
        barcode: json["barcode"] == null ? null : json["barcode"],
      );

  Map<String, dynamic> toJson() => {
        "label": label == null ? null : label,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "base64": base64 == null ? null : base64,
        "bincolor": bincolor == null ? null : bincolor,
        "points": points == null ? null : points,
        "totalproduct": totalproduct == null ? null : totalproduct,
        "datetaken": dateTaken == null ? null : dateTaken,
        "barcode": barcode == null ? null : barcode,
      };
}
