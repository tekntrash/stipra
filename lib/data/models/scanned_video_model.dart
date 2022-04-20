import 'package:hive/hive.dart';
import 'barcode_timestamp_model.dart';
import '../../domain/entities/scanned_video.dart';
part 'scanned_video_model.g.dart';

@HiveType(typeId: 1)
// ignore: must_be_immutable
class ScannedVideoModel extends ScannedVideo with HiveObjectMixin {
  @HiveField(0)
  final int timeStamp;
  @HiveField(1)
  final String videoPath;
  @HiveField(2)
  bool isUploaded;
  @HiveField(3)
  List<BarcodeTimeStampModel> barcodeTimeStamps;

  ScannedVideoModel({
    required this.timeStamp,
    required this.videoPath,
    required this.isUploaded,
    required this.barcodeTimeStamps,
  }) : super(
          timeStamp: timeStamp,
          videoPath: videoPath,
          isUploaded: isUploaded,
          barcodeTimeStamps: barcodeTimeStamps,
        );

  factory ScannedVideoModel.fromJson(Map<String, dynamic> json) {
    return ScannedVideoModel(
      timeStamp: json['timeStamp'] as int,
      videoPath: json['videoPath'] as String,
      isUploaded: json['isUploaded'] as bool,
      barcodeTimeStamps: (json['barcodeTimeStamps'] as List)
          .map((e) => BarcodeTimeStampModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timeStamp': timeStamp,
      'videoPath': videoPath,
      'isUploaded': isUploaded,
      'barcodeTimeStamps': barcodeTimeStamps,
    };
  }
}
