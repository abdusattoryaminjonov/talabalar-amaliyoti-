// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LanguageModelAdapter extends TypeAdapter<LanguageModel> {
  @override
  final int typeId = 8;

  @override
  LanguageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LanguageModel(
      type: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LanguageModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
