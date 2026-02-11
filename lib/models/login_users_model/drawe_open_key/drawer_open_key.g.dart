// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawer_open_key.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DrawerOpenKeyAdapter extends TypeAdapter<DrawerOpenKey> {
  @override
  final int typeId = 7;

  @override
  DrawerOpenKey read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DrawerOpenKey(
      status: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DrawerOpenKey obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrawerOpenKeyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
