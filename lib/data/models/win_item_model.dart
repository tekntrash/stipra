import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';
import 'package:stipra/domain/entities/win_item.dart';

part 'win_item_model.g.dart';

// ignore: must_be_immutable
@HiveType(typeId: 4)
class WinItemModel extends WinItem with HiveObjectMixin {
  WinItemModel({
    this.item,
    this.images,
    this.name,
    this.description,
    this.points,
    this.enddate,
    this.barcode,
    this.geo,
    this.bincolor,
    this.categorydatabase,
    this.featuredend,
    this.featuredstart,
    this.id,
  }) : super(
          item: item,
          images: images,
          name: name,
          description: description,
          points: points,
          enddate: enddate,
          barcode: barcode,
          geo: geo,
          bincolor: bincolor,
          categorydatabase: categorydatabase,
          featuredend: featuredend,
          featuredstart: featuredstart,
          id: id,
        );

  @HiveField(0)
  int? item;
  @HiveField(1)
  List<String>? images;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? points;
  @HiveField(5)
  String? enddate;
  @HiveField(6)
  String? barcode;
  @HiveField(7)
  String? geo;
  @HiveField(8)
  String? bincolor;
  @HiveField(9)
  String? categorydatabase;
  @HiveField(10)
  DateTime? featuredstart;
  @HiveField(11)
  DateTime? featuredend;
  @HiveField(12)
  String? id;

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
        geo: json["geo"] == null ? null : json["geo"],
        bincolor: json["bincolor"] == null ? null : json["bincolor"],
        categorydatabase:
            json["categorydatabase"] == null ? null : json["categorydatabase"],
        featuredstart: json["featuredstart"] == null
            ? null
            : DateTime.parse(json["featuredstart"]),
        featuredend: json["featuredend"] == null
            ? null
            : DateTime.parse(json["featuredend"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "item": item == null ? null : item,
        "images": images == null ? null : images,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "points": points == null ? null : points,
        "enddate": enddate == null ? null : enddate,
        "barcode": barcode == null ? null : barcode,
        "geo": geo == null ? null : geo,
        "bincolor": bincolor == null ? null : bincolor,
        "categorydatabase": categorydatabase == null ? null : categorydatabase,
        "featuredstart": featuredstart == null
            ? null
            : "${featuredstart?.year.toString().padLeft(4, '0')}-${featuredstart?.month.toString().padLeft(2, '0')}-${featuredstart?.day.toString().padLeft(2, '0')}",
        "featuredend": featuredend == null
            ? null
            : "${featuredend?.year.toString().padLeft(4, '0')}-${featuredend?.month.toString().padLeft(2, '0')}-${featuredend?.day.toString().padLeft(2, '0')}",
        "id": id == null ? null : id,
      };

  Color getBinColor() {
    if (bincolor == '1') {
      return Colors.blue;
    } else if (bincolor == '2') {
      return Colors.green;
    } else if (bincolor == '3') {
      return Colors.yellow;
    } else if (bincolor == '4') {
      return Colors.red;
    }
    return Colors.transparent;
  }
}
