// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university_teacher_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UniversityTeacherAdapter extends TypeAdapter<UniversityTeacher> {
  @override
  final int typeId = 5;

  @override
  UniversityTeacher read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UniversityTeacher(
      id: fields[0] as int,
      fullName: fields[1] as String,
      phoneNumber: fields[2] as String,
      passport: fields[3] as String,
      rate: fields[4] as String,
      position: fields[5] as String,
      universityName: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UniversityTeacher obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.passport)
      ..writeByte(4)
      ..write(obj.rate)
      ..writeByte(5)
      ..write(obj.position)
      ..writeByte(6)
      ..write(obj.universityName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UniversityTeacherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
