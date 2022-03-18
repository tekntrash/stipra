import 'package:stipra/domain/entities/offer.dart';

class OfferModel extends Offer {
  final String? title;
  final String? desc;
  final String? image;
  final String? startDate;
  final String? endDate;

  OfferModel({this.title, this.desc, this.image, this.startDate, this.endDate})
      : super(
          title: title,
          desc: desc,
          image: image,
          startDate: startDate,
          endDate: endDate,
        );

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        title: json["title"] == null ? null : json["title"],
        desc: json["desc"] == null ? null : json["desc"],
        image: json["image"] == null ? null : json["image"],
        startDate: json["start_date"] == null ? null : json["start_date"],
        endDate: json["end_date"] == null ? null : json["end_date"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "desc": desc == null ? null : desc,
        "image": image == null ? null : image,
        "start_date": startDate == null ? null : startDate,
        "end_date": endDate == null ? null : endDate,
      };
}
