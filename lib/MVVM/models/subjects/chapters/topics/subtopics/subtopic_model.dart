// enum SelectedSubject { biology, physics, chemistry }

import 'package:hive/hive.dart';

import '../../../../questions/question_model.dart';

class SubTopicModel extends HiveObject {
  final String subTopicName;

  final String topicName;

  List<QuestionModel> questions;

  int progressCount;

  SubTopicModel({
    required this.subTopicName,
    required this.topicName,
    required this.questions,
    this.progressCount = 0,
  });
}
