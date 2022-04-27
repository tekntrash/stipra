import 'dart:convert';

import 'package:stipra/domain/entities/trade_item.dart';

class TradeItemModel extends TradeItem {
  TradeItemModel({
    this.item,
    this.image,
    this.level,
    this.name,
    this.category,
    this.enddate,
    this.description,
    this.points,
    this.minimumpoints,
    this.maximumpoints,
  }) : super(
          item: item,
          image: image,
          level: level,
          name: name,
          category: category,
          enddate: enddate,
          description: description,
          points: points,
          minimumpoints: minimumpoints,
          maximumpoints: maximumpoints,
        );

  int? item;
  String? image;
  String? level;
  String? name;
  String? category;
  String? enddate;
  String? description;
  String? points;
  String? minimumpoints;
  String? maximumpoints;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => TradeItemModel(
        item: json["item"] == null ? null : json["item"],
        image: json["image"] == null ? null : json["image"],
        level: json["level"] == null ? null : json["level"],
        name: json["name"] == null ? null : json["name"],
        category: json["category"] == null ? null : json["category"],
        enddate: json["enddate"] == null ? null : json["enddate"],
        description: json["description"] == null ? null : json["description"],
        points: json["points"] == null ? null : json["points"],
        minimumpoints:
            json["minimumpoints"] == null ? null : json["minimumpoints"],
        maximumpoints:
            json["maximumpoints"] == null ? null : json["maximumpoints"],
      );

  Map<String, dynamic> toJson() => {
        "item": item == null ? null : item,
        "image": image == null ? null : image,
        "level": level == null ? null : level,
        "name": name == null ? null : name,
        "category": category == null ? null : category,
        "enddate": enddate == null ? null : enddate,
        "description": description == null ? null : description,
        "points": points == null ? null : points,
        "minimumpoints": minimumpoints == null ? null : minimumpoints,
        "maximumpoints": maximumpoints == null ? null : maximumpoints,
      };
}
