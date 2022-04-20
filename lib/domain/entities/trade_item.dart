import 'package:equatable/equatable.dart';

class TradeItem extends Equatable {
  TradeItem({
    this.item,
    this.image,
    this.level,
    this.enddate,
    this.name,
    this.description,
  });

  int? item;
  String? image;
  String? level;
  String? enddate;
  String? name;
  String? description;

  @override
  List<Object?> get props => [
        item,
        image,
        level,
        enddate,
        name,
        description,
      ];
}
