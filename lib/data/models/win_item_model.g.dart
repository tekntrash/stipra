// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'win_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WinItemModelAdapter extends TypeAdapter<WinItemModel> {
  @override
  final int typeId = 4;

  @override
  WinItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WinItemModel(
      item: fields[0] as int?,
      images: (fields[1] as List?)?.cast<String>(),
      name: fields[2] as String?,
      description: fields[3] as String?,
      points: fields[4] as String?,
      enddate: fields[5] as String?,
      barcode: fields[6] as String?,
      geo: fields[7] as String?,
      bincolor: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WinItemModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.item)
      ..writeByte(1)
      ..write(obj.images)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.points)
      ..writeByte(5)
      ..write(obj.enddate)
      ..writeByte(6)
      ..write(obj.barcode)
      ..writeByte(7)
      ..write(obj.geo)
      ..writeByte(8)
      ..write(obj.bincolor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WinItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}