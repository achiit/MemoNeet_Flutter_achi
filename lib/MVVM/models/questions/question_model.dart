import 'package:hive/hive.dart';

part 'question_model.g.dart';

@HiveType(typeId: 0)
class QuestionModel extends HiveObject {
  @HiveField(0)
  final String uniqueId;

  @HiveField(1)
  final String question;

  @HiveField(2)
  final String answer;

  @HiveField(3)
  final String explanation;

  @HiveField(4)
  final String topicName;

  @HiveField(5)
  final String difficultyLevel;

  @HiveField(6)
  final String optionA;

  @HiveField(7)
  final String optionB;

  @HiveField(8)
  final String optionC;

  @HiveField(9)
  final String optionD;

  @HiveField(10)
  final String quizType;

  QuestionModel({
    required this.uniqueId,
    required this.question,
    required this.answer,
    required this.explanation,
    required this.topicName,
    required this.difficultyLevel,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.quizType,
  });

  Map<String, dynamic> toMap() {
    return {
      'uniqueId': uniqueId,
      'question': question,
      'answer': answer,
      'explanation': explanation,
      'topicName': topicName,
      'difficultyLevel': difficultyLevel,
      'optionA': optionA,
      'optionB': optionB,
      'optionC': optionC,
      'optionD': optionD,
      'quizType': quizType,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      uniqueId: map['uniqueId'].toString(),
      question: map['question'],
      answer: map['answer'],
      explanation: map['explanation'],
      topicName: map['topicName'],
      difficultyLevel: map['difficultyLevel'],
      optionA: map['optionA'],
      optionB: map['optionB'],
      optionC: map['optionC'],
      optionD: map['optionD'],
      quizType: map['quizType'],
    );
  }
}
