import 'package:equatable/equatable.dart';

class TradeItem extends Equatable {
  TradeItem({
    this.item,
    this.image,
    this.level,
    this.name,
    this.category,
    this.enddate,
    this.description,
    this.points,
    this.minimumpoints,
    this.maximumpoints,
  });

  int? item;
  String? image;
  String? level;
  String? name;
  String? category;
  String? enddate;
  String? description;
  String? points;
  String? minimumpoints;
  String? maximumpoints;

  @override
  List<Object?> get props => [
        item,
        image,
        level,
        name,
        category,
        enddate,
        description,
        points,
        minimumpoints,
        maximumpoints,
      ];
}
