import 'package:equatable/equatable.dart';

class Offer extends Equatable {
  final String? title;
  final String? desc;
  final String? image;
  final String? startDate;
  final String? endDate;

  Offer({this.title, this.desc, this.image, this.startDate, this.endDate});

  @override
  List<Object?> get props => [title, desc, image, startDate, endDate];
}
