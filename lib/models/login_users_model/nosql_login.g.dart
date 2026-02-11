// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nosql_login.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginUserDataAdapter extends TypeAdapter<LoginUserData> {
  @override
  final int typeId = 4;

  @override
  LoginUserData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginUserData(
      message: fields[0] as String,
      status: fields[1] as int,
      accessToken: fields[2] as String,
      refreshToken: fields[3] as String,
      role: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LoginUserData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.accessToken)
      ..writeByte(3)
      ..write(obj.refreshToken)
      ..writeByte(4)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginUserDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
