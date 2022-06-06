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
      categorydatabase: fields[9] as String?,
      featuredend: fields[11] as DateTime?,
      featuredstart: fields[10] as DateTime?,
      id: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WinItemModel obj) {
    writer
      ..writeByte(13)
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
      ..write(obj.bincolor)
      ..writeByte(9)
      ..write(obj.categorydatabase)
      ..writeByte(10)
      ..write(obj.featuredstart)
      ..writeByte(11)
      ..write(obj.featuredend)
      ..writeByte(12)
      ..write(obj.id);
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
