import 'package:equatable/equatable.dart';

import 'barcode_timestamp.dart';

// ignore: must_be_immutable
class ScannedVideo extends Equatable {
  final int timeStamp;
  final String videoPath;
  bool isUploaded;
  final List<BarcodeTimeStamp> barcodeTimeStamps;
  ScannedVideo({
    required this.timeStamp,
    required this.videoPath,
    required this.isUploaded,
    required this.barcodeTimeStamps,
  });

  @override
  List<Object> get props => [timeStamp, videoPath, isUploaded];
}
