// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ErrorModelAdapter extends TypeAdapter<ErrorModel> {
  @override
  final int typeId = 6;

  @override
  ErrorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ErrorModel(
      tag: fields[0] as String,
      message: fields[1] as String,
      timestamp: fields[2] as int,
      isUploaded: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ErrorModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.tag)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.isUploaded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ErrorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
