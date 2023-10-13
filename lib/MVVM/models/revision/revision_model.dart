import 'package:hive/hive.dart';

import '../questions/question_model.dart';

part 'revision_model.g.dart';

@HiveType(typeId: 8)
class RevisionModel {
  @HiveField(0)
  QuestionModel questions;
  @HiveField(1)
  int level;
  @HiveField(3)
  DateTime date;

  RevisionModel({
    required this.questions,
    required this.level,
    required this.date,
  });
}
