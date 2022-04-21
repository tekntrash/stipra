import 'package:equatable/equatable.dart';

class WinItem extends Equatable {
  WinItem({
    this.item,
    this.images,
    this.name,
    this.description,
    this.points,
    this.enddate,
    this.barcode,
    this.geo,
    this.bincolor,
  });

  int? item;
  List<String>? images;
  String? name;
  String? description;
  String? points;
  String? enddate;
  String? barcode;
  String? geo;
  String? bincolor;

  @override
  List<Object?> get props => [
        item,
        images,
        name,
        description,
        points,
        enddate,
        barcode,
        geo,
        bincolor
      ];
}
