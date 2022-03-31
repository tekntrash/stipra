import 'package:equatable/equatable.dart';

class BarcodeTimeStamp extends Equatable {
  final String timeStamp;
  final String barcode;
  final String videoName;
  BarcodeTimeStamp({
    required this.timeStamp,
    required this.barcode,
    required this.videoName,
  });

  @override
  List<Object> get props => [timeStamp, barcode, videoName];
}
