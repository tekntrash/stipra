import 'package:equatable/equatable.dart';

class MyTrade extends Equatable {
  MyTrade({
    this.date,
    this.description,
    this.image,
    this.points,
    this.totalpointstraded,
  });

  final String? date;
  final String? description;
  final String? image;
  final String? points;
  final int? totalpointstraded;

  @override
  List<Object?> get props => [
        date,
        description,
        image,
        points,
        totalpointstraded,
      ];
}
