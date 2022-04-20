import 'dart:convert';

import 'package:stipra/domain/entities/win_item.dart';

class WinItemModel extends WinItem {
  WinItemModel({
    this.item,
    this.images,
    this.name,
    this.description,
    this.points,
    this.enddate,
    this.barcode,
  }) : super(
          item: item,
          images: images,
          name: name,
          description: description,
          points: points,
          enddate: enddate,
          barcode: barcode,
        );

  int? item;
  List<String>? images;
  String? name;
  String? description;
  String? points;
  String? enddate;
  String? barcode;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => WinItemModel(
        item: json["item"] == null ? null : json["item"],
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        points: json["points"] == null ? null : json["points"],
        enddate: json["enddate"] == null ? null : json["enddate"],
        barcode: json["barcode"] == null ? null : json["barcode"],
      );

  Map<String, dynamic> toJson() => {
        "item": item == null ? null : item,
        "images": images == null ? null : images,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "points": points == null ? null : points,
        "enddate": enddate == null ? null : enddate,
        "barcode": barcode == null ? null : barcode,
      };
}
