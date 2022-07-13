import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'privacy_model.g.dart';

@HiveType(typeId: 7)
class PrivacyModel extends Equatable with HiveObjectMixin {
  @HiveField(0)
  bool? receivenotifications;

  @HiveField(1)
  bool? receiveemailspoints;

  @HiveField(2)
  bool? receivenewsletter;

  PrivacyModel({
    this.receivenotifications,
    this.receiveemailspoints,
    this.receivenewsletter,
  });

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => PrivacyModel(
        receivenotifications:
            json["receivenotifications"] == 'on' ? true : false,
        receiveemailspoints: json["receiveemailspoints"] == 'on' ? true : false,
        receivenewsletter: json["receivenewsletter"] == 'on' ? true : false,
      );

  updateFromJson(Map<String, dynamic> json) => PrivacyModel(
        receivenotifications:
            json["receivenotifications"] == 'on' ? true : false,
        receiveemailspoints: json["receiveemailspoints"] == 'on' ? true : false,
        receivenewsletter: json["receivenewsletter"] == 'on' ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "receivenotifications": receivenotifications == true ? 'on' : 'off',
        "receiveemailspoints": receiveemailspoints == true ? 'on' : 'off',
        "receivenewsletter": receivenewsletter == true ? 'on' : 'off',
      };

  @override
  String toString() {
    return 'PrivacyModel{receivenotifications: $receivenotifications, receiveemailspoints: $receiveemailspoints, receivenewsletter: $receivenewsletter}';
  }

  @override
  List<Object?> get props => [
        receivenotifications,
        receiveemailspoints,
        receivenewsletter,
      ];
}
