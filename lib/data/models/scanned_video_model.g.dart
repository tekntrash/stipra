// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanned_video_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScannedVideoModelAdapter extends TypeAdapter<ScannedVideoModel> {
  @override
  final int typeId = 1;

  @override
  ScannedVideoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScannedVideoModel(
      timeStamp: fields[0] as int,
      videoPath: fields[1] as String,
      isUploaded: fields[2] as bool,
      barcodeTimeStamps: (fields[3] as List).cast<BarcodeTimeStampModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ScannedVideoModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.timeStamp)
      ..writeByte(1)
      ..write(obj.videoPath)
      ..writeByte(2)
      ..write(obj.isUploaded)
      ..writeByte(3)
      ..write(obj.barcodeTimeStamps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScannedVideoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
