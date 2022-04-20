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
  });

  int? item;
  List<String>? images;
  String? name;
  String? description;
  String? points;
  String? enddate;
  String? barcode;

  @override
  List<Object?> get props =>
      [item, images, name, description, points, enddate, barcode];
}
