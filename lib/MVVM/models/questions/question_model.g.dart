// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionModelAdapter extends TypeAdapter<QuestionModel> {
  @override
  final int typeId = 0;

  @override
  QuestionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionModel(
      uniqueId: fields[0] as String,
      question: fields[1] as String,
      answer: fields[2] as String,
      explanation: fields[3] as String,
      topicName: fields[4] as String,
      difficultyLevel: fields[5] as String,
      optionA: fields[6] as String,
      optionB: fields[7] as String,
      optionC: fields[8] as String,
      optionD: fields[9] as String,
      quizType: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.uniqueId)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.answer)
      ..writeByte(3)
      ..write(obj.explanation)
      ..writeByte(4)
      ..write(obj.topicName)
      ..writeByte(5)
      ..write(obj.difficultyLevel)
      ..writeByte(6)
      ..write(obj.optionA)
      ..writeByte(7)
      ..write(obj.optionB)
      ..writeByte(8)
      ..write(obj.optionC)
      ..writeByte(9)
      ..write(obj.optionD)
      ..writeByte(10)
      ..write(obj.quizType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
