// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revision_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RevisionListModelAdapter extends TypeAdapter<RevisionListModel> {
  @override
  final int typeId = 9;

  @override
  RevisionListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RevisionListModel(
      subject: fields[0] as String,
      revisionQuestions: (fields[1] as List).cast<RevisionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, RevisionListModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.subject)
      ..writeByte(1)
      ..write(obj.revisionQuestions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RevisionListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
