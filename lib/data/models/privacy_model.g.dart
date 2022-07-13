// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrivacyModelAdapter extends TypeAdapter<PrivacyModel> {
  @override
  final int typeId = 7;

  @override
  PrivacyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrivacyModel(
      receivenotifications: fields[0] as bool?,
      receiveemailspoints: fields[1] as bool?,
      receivenewsletter: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PrivacyModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.receivenotifications)
      ..writeByte(1)
      ..write(obj.receiveemailspoints)
      ..writeByte(2)
      ..write(obj.receivenewsletter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrivacyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
