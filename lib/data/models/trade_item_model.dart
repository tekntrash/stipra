import 'dart:convert';

import 'package:stipra/domain/entities/trade_item.dart';

class TradeItemModel extends TradeItem {
  TradeItemModel({
    this.item,
    this.image,
    this.level,
    this.name,
    this.description,
    this.enddate,
  }) : super(
          item: item,
          image: image,
          level: level,
          name: name,
          enddate: enddate,
          description: description,
        );

  int? item;
  String? image;
  String? level;
  String? name;
  String? enddate;
  String? description;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => TradeItemModel(
        item: json["item"] == null ? null : json["item"],
        image: json["image"] == null ? null : json["image"],
        level: json["level"] == null ? null : json["level"],
        name: json["name"] == null ? null : json["name"],
        enddate: json["enddate"] == null ? null : json["enddate"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "item": item == null ? null : item,
        "image": image == null ? null : image,
        "level": level == null ? null : level,
        "name": name == null ? null : name,
        "enddate": enddate == null ? null : enddate,
        "description": description == null ? null : description,
      };
}
