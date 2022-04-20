import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/barcode_timestamp.dart';
part 'barcode_timestamp_model.g.dart';

@HiveType(typeId: 2)
class BarcodeTimeStampModel extends BarcodeTimeStamp with HiveObjectMixin {
  @HiveField(0)
  final String timeStamp;
  @HiveField(1)
  final String barcode;

  BarcodeTimeStampModel({
    required this.timeStamp,
    required this.barcode,
  }) : super(
          timeStamp: timeStamp,
          barcode: barcode,
        );

  factory BarcodeTimeStampModel.fromJson(Map<String, dynamic> json) {
    return BarcodeTimeStampModel(
      timeStamp: json['timeStamp'] as String,
      barcode: json['barcode'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timeStamp': timeStamp,
      'barcode': barcode,
    };
  }
}
