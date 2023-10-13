// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crossword_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CrosswordModelAdapter extends TypeAdapter<CrosswordModel> {
  @override
  final int typeId = 10;

  @override
  CrosswordModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CrosswordModel(
      topic: fields[0] as String,
      crossword: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CrosswordModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.topic)
      ..writeByte(1)
      ..write(obj.crossword);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CrosswordModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
