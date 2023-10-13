// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionListModelAdapter extends TypeAdapter<QuestionListModel> {
  @override
  final int typeId = 1;

  @override
  QuestionListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionListModel(
      questionList: (fields[0] as List).cast<QuestionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuestionListModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.questionList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
