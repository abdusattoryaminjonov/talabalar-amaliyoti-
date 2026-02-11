// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internship_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InternshipModelAdapter extends TypeAdapter<InternshipModel> {
  @override
  final int typeId = 6;

  @override
  InternshipModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InternshipModel(
      id: fields[0] as int,
      name: fields[1] as String,
      activeStartAt: fields[2] as String,
      activeEndAt: fields[3] as String,
      status: fields[4] as String,
      description: fields[5] as String,
      createdDate: fields[6] as String,
      updatedDate: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InternshipModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.activeStartAt)
      ..writeByte(3)
      ..write(obj.activeEndAt)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.createdDate)
      ..writeByte(7)
      ..write(obj.updatedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InternshipModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
