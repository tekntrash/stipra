import 'dart:convert';

import '../../domain/entities/my_trade.dart';

class MyTradeModel extends MyTrade {
  MyTradeModel({
    this.date,
    this.description,
    this.image,
    this.points,
    this.totalpointstraded,
  }) : super(
          date: date,
          description: description,
          image: image,
          points: points,
          totalpointstraded: totalpointstraded,
        );

  final String? date;
  final String? description;
  final String? image;
  final String? points;
  final int? totalpointstraded;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  MyTradeModel copyWith({
    String? date,
    String? description,
    String? image,
    String? points,
    int? totalpointstraded,
  }) =>
      MyTradeModel(
        date: date ?? this.date,
        description: description ?? this.description,
        image: image ?? this.image,
        points: points ?? this.points,
        totalpointstraded: totalpointstraded ?? this.totalpointstraded,
      );

  fromJson(Map<String, dynamic> json) => MyTradeModel(
        date: json["date"] == null ? null : json["date"],
        description: json["description"] == null ? null : json["description"],
        image: json["image"] == null ? null : json["image"],
        points: json["points"] == null ? null : json["points"],
        totalpointstraded: json["totalpointstraded"] == null
            ? null
            : json["totalpointstraded"],
      );

  Map<String, dynamic> toJson() => {
        "date": date == null ? null : date,
        "description": description == null ? null : description,
        "image": image == null ? null : image,
        "points": points == null ? null : points,
        "totalpointstraded":
            totalpointstraded == null ? null : totalpointstraded,
      };
}
