// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TradeItemModelAdapter extends TypeAdapter<TradeItemModel> {
  @override
  final int typeId = 5;

  @override
  TradeItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TradeItemModel(
      id: fields[1] as String?,
      item: fields[0] as int?,
      images: (fields[11] as List?)?.cast<String>(),
      level: fields[3] as String?,
      name: fields[4] as String?,
      category: fields[5] as String?,
      enddate: fields[6] as String?,
      description: fields[7] as String?,
      points: fields[8] as String?,
      minimumpoints: fields[9] as String?,
      maximumpoints: fields[10] as String?,
    )..image = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, TradeItemModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.item)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.level)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.enddate)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.points)
      ..writeByte(9)
      ..write(obj.minimumpoints)
      ..writeByte(10)
      ..write(obj.maximumpoints)
      ..writeByte(11)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TradeItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
