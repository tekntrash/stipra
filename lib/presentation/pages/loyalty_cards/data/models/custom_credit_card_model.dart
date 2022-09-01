import 'dart:convert';

import 'package:rest_api_package/rest_api_package.dart';

export '../enums/card_brand_specs.dart';

class CustomCreditCardModel extends IRestApiBaseModel {
  CustomCreditCardModel({
    this.cardNumber: '',
    this.expiryDate: '',
    this.cardHolderName: '',
    this.cardIssuerName: '',
  });

  String? cardNumber;
  String? expiryDate;
  String? cardHolderName;
  String? cardIssuerName;

  @override
  fromRawJson(String str) => fromJson(json.decode(str));

  @override
  String toRawJson() => json.encode(toJson());

  @override
  fromJson(Map<String, dynamic> json) => CustomCreditCardModel(
        cardNumber: json["cardNumber"] == null ? null : json["cardNumber"],
        expiryDate: json["expiryDate"] == null ? null : json["expiryDate"],
        cardHolderName:
            json["cardHolderName"] == null ? null : json["cardHolderName"],
        cardIssuerName:
            json["cardIssuerName"] == null ? null : json["cardIssuerName"],
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'cardNumber': this.cardNumber,
      'expiryDate': this.expiryDate,
      'cardHolderName': this.cardHolderName,
      'cardIssuerName': this.cardIssuerName,
    };
  }
}
