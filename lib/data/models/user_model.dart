import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:stipra/domain/entities/user.dart';
part 'user_model.g.dart';

@HiveType(typeId: 3)
// ignore: must_be_immutable
class UserModel extends User with HiveObjectMixin {
  UserModel({
    this.alogin,
    this.name,
    this.userid,
    this.stayLoggedIn,
    this.otp,
  }) : super(
          alogin: alogin,
          name: name,
          userid: userid,
          stayLoggedIn: stayLoggedIn,
          otp: otp,
        );

  @HiveField(0)
  String? alogin;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? userid;
  @HiveField(3)
  bool? stayLoggedIn;
  @HiveField(4)
  String? otp;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  updateFromJson(Map<String, dynamic> json) {
    alogin = json["alogin"] ?? alogin;
    name = json["name"] ?? name;
    userid = json["userid"] ?? userid;
    stayLoggedIn = json["stayLoggedIn"] ?? stayLoggedIn;
    otp = json["otp"] ?? otp;
  }

  fromJson(Map<String, dynamic> json) => UserModel(
        alogin: json["alogin"] == null ? null : json["alogin"],
        name: json["name"] == null ? null : json["name"],
        userid: json["userid"] == null ? null : json["userid"],
        stayLoggedIn:
            json["stayLoggedIn"] == null ? null : json["stayLoggedIn"],
        otp: json["otp"] == null ? null : json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "alogin": alogin == null ? null : alogin,
        "name": name == null ? null : name,
        "userid": userid == null ? null : userid,
        "stayLoggedIn": stayLoggedIn == null ? null : stayLoggedIn,
        "otp": otp == null ? null : otp,
      };
}