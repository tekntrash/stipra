import 'package:equatable/equatable.dart';

class BarcodeTimeStamp extends Equatable {
  final String timeStamp;
  final String barcode;
  BarcodeTimeStamp({
    required this.timeStamp,
    required this.barcode,
  });

  @override
  List<Object> get props => [timeStamp, barcode];
}
