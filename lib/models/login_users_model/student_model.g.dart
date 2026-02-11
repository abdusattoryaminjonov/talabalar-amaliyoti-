// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentModelAdapter extends TypeAdapter<StudentModel> {
  @override
  final int typeId = 0;

  @override
  StudentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentModel(
      fullName: fields[0] as String,
      externalId: fields[1] as String,
      email: fields[2] as String,
      passport: fields[3] as String,
      pinFl: fields[4] as String,
      citizenship: fields[5] as String,
      nationality: fields[6] as String,
      imageUrl: fields[7] as String?,
      birthDate: fields[8] as String,
      gender: fields[9] as String,
      region: fields[10] as String,
      district: fields[11] as String,
      status: fields[12] as String,
      educationLanguage: fields[13] as String,
      educationForm: fields[14] as String,
      educationType: fields[15] as String,
      course: fields[16] as int,
      username: fields[17] as String,
      role: fields[18] as String,
      semester: fields[19] as int,
      faculty: fields[20] as Faculty,
      group: fields[21] as Group,
      speciality: fields[22] as Speciality,
    );
  }

  @override
  void write(BinaryWriter writer, StudentModel obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.externalId)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.passport)
      ..writeByte(4)
      ..write(obj.pinFl)
      ..writeByte(5)
      ..write(obj.citizenship)
      ..writeByte(6)
      ..write(obj.nationality)
      ..writeByte(7)
      ..write(obj.imageUrl)
      ..writeByte(8)
      ..write(obj.birthDate)
      ..writeByte(9)
      ..write(obj.gender)
      ..writeByte(10)
      ..write(obj.region)
      ..writeByte(11)
      ..write(obj.district)
      ..writeByte(12)
      ..write(obj.status)
      ..writeByte(13)
      ..write(obj.educationLanguage)
      ..writeByte(14)
      ..write(obj.educationForm)
      ..writeByte(15)
      ..write(obj.educationType)
      ..writeByte(16)
      ..write(obj.course)
      ..writeByte(17)
      ..write(obj.username)
      ..writeByte(18)
      ..write(obj.role)
      ..writeByte(19)
      ..write(obj.semester)
      ..writeByte(20)
      ..write(obj.faculty)
      ..writeByte(21)
      ..write(obj.group)
      ..writeByte(22)
      ..write(obj.speciality);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FacultyAdapter extends TypeAdapter<Faculty> {
  @override
  final int typeId = 1;

  @override
  Faculty read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Faculty(
      id: fields[0] as int,
      name: fields[1] as String,
      code: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Faculty obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.code);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FacultyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GroupAdapter extends TypeAdapter<Group> {
  @override
  final int typeId = 2;

  @override
  Group read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Group(
      id: fields[0] as int,
      name: fields[1] as String,
      code: fields[2] as String,
      educationLanguage: fields[3] as String,
      semester: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Group obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.educationLanguage)
      ..writeByte(4)
      ..write(obj.semester);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpecialityAdapter extends TypeAdapter<Speciality> {
  @override
  final int typeId = 3;

  @override
  Speciality read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Speciality(
      id: fields[0] as int,
      code: fields[1] as String,
      name: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Speciality obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpecialityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
