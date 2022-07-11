import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:stipra/domain/entities/trade_item.dart';

part 'trade_item_model.g.dart';

@HiveType(typeId: 5)
class TradeItemModel extends TradeItem with HiveObjectMixin {
  TradeItemModel({
    this.id,
    this.item,
    this.images,
    this.level,
    this.name,
    this.category,
    this.enddate,
    this.description,
    this.points,
    this.minimumpoints,
    this.maximumpoints,
  }) : super(
          id: id,
          item: item,
          images: images,
          level: level,
          name: name,
          category: category,
          enddate: enddate,
          description: description,
          points: points,
          minimumpoints: minimumpoints,
          maximumpoints: maximumpoints,
        );

  @HiveField(0)
  int? item;
  @HiveField(1)
  String? id;
  @HiveField(2)
  String? image;
  @HiveField(3)
  String? level;
  @HiveField(4)
  String? name;
  @HiveField(5)
  String? category;
  @HiveField(6)
  String? enddate;
  @HiveField(7)
  String? description;
  @HiveField(8)
  String? points;
  @HiveField(9)
  String? minimumpoints;
  @HiveField(10)
  String? maximumpoints;
  @HiveField(11)
  List<String>? images;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => TradeItemModel(
        id: json["id"],
        item: json["item"] == null ? null : json["item"],
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
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
        "id": id == null ? null : id,
        "item": item == null ? null : item,
        "images": images == null ? null : images,
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
