import 'package:hive/hive.dart';

part 'mcq_model.g.dart';

@HiveType(typeId: 0)
class McqModel extends HiveObject {
  @HiveField(0)
  int? uniqueId;

  @HiveField(1)
  String? question;

  @HiveField(2)
  String? answer;

  @HiveField(3)
  String? explanation;

  @HiveField(4)
  String? topicName;

  @HiveField(5)
  int? difficultyLevel;

  @HiveField(6)
  String? optionA;

  @HiveField(7)
  String? optionB;

  @HiveField(8)
  String? optionC;

  @HiveField(9)
  String? optionD;

  @HiveField(10)
  String? quizType;

  McqModel({
    this.uniqueId,
    this.question,
    this.answer,
    this.explanation,
    this.topicName,
    this.difficultyLevel,
    this.optionA,
    this.optionB,
    this.optionC,
    this.optionD,
    this.quizType,
  });

  factory McqModel.fromJson(Map<String, dynamic> json) => McqModel(
        uniqueId: json["unique_id"],
        question: json["question"],
        answer: json["answer"],
        explanation: json["explanation"],
        topicName: json["topic_name"],
        difficultyLevel: json["difficulty_level"],
        optionA: json["option_a"],
        optionB: json["option_b"],
        optionC: json["option_c"],
        optionD: json["option_d"],
        quizType: json["quiz_type"],
      );

  Map<String, dynamic> toJson() => {
        "unique_id": uniqueId,
        "question": question,
        "answer": answer,
        "explanation": explanation,
        "topic_name": topicName,
        "difficulty_level": difficultyLevel,
        "option_a": optionA,
        "option_b": optionB,
        "option_c": optionC,
        "option_d": optionD,
        "quiz_type": quizType,
      };
}
