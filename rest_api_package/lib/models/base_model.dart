part of '../rest_api_package.dart';

abstract class IRestApiBaseModel {
  fromRawJson(String str);

  String toRawJson();

  fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}
