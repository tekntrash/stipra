// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_timestamp_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarcodeTimeStampModelAdapter extends TypeAdapter<BarcodeTimeStampModel> {
  @override
  final int typeId = 2;

  @override
  BarcodeTimeStampModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarcodeTimeStampModel(
      timeStamp: fields[0] as String,
      barcode: fields[1] as String,
      videoName: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BarcodeTimeStampModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.timeStamp)
      ..writeByte(1)
      ..write(obj.barcode)
      ..writeByte(2)
      ..write(obj.videoName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarcodeTimeStampModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
