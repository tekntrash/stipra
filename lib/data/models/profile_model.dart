import 'dart:convert';

import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    this.zipcode,
    this.address,
    this.city,
    this.country,
    this.gender,
    this.dobday,
    this.dobmonth,
    this.dobyear,
  });

  final String? zipcode;
  final String? address;
  final String? city;
  final String? country;
  final String? gender;
  final String? dobday;
  final String? dobmonth;
  final String? dobyear;

  fromRawJson(String str) => fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  fromJson(Map<String, dynamic> json) => ProfileModel(
        zipcode: json["zipcode"] == null ? null : json["zipcode"],
        address: json["address"] == null ? null : json["address"],
        city: json["city"] == null ? null : json["city"],
        country: json["country"] == null ? null : json["country"],
        gender: json["gender"] == null ? null : json["gender"],
        dobday: json["dobday"] == null ? null : json["dobday"],
        dobmonth: json["dobmonth"] == null ? null : json["dobmonth"],
        dobyear: json["dobyear"] == null ? null : json["dobyear"],
      );

  Map<String, dynamic> toJson() => {
        "zipcode": zipcode == null ? null : zipcode,
        "address": address == null ? null : address,
        "city": city == null ? null : city,
        "country": country == null ? null : country,
        "gender": gender == null ? null : gender,
        "dobday": dobday == null ? null : dobday,
        "dobmonth": dobmonth == null ? null : dobmonth,
        "dobyear": dobyear == null ? null : dobyear,
      };
}
