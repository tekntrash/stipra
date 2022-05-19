// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 3;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      alogin: fields[0] as String?,
      name: fields[1] as String?,
      userid: fields[2] as String?,
      stayLoggedIn: fields[3] as bool?,
      otp: fields[4] as String?,
      image: fields[5] as String?,
      lastLoginTime: fields[6] as DateTime?,
      points: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.alogin)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.userid)
      ..writeByte(3)
      ..write(obj.stayLoggedIn)
      ..writeByte(4)
      ..write(obj.otp)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.lastLoginTime)
      ..writeByte(7)
      ..write(obj.points);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
