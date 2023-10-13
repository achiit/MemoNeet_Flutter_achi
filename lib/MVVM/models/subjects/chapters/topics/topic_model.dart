// enum SelectedSubject { biology, physics, chemistry }

import 'package:hive/hive.dart';

class TopicModel extends HiveObject {
  final String topicName;
  final String uidStart;
  final String uidEnd;
  final bool isBookmark;
  int numberOfQuestions;
  int progressCount;

  TopicModel(
      {required this.topicName,
      this.numberOfQuestions = 0,
      this.progressCount = 0,
      required this.uidStart,
      required this.uidEnd,
      this.isBookmark = false});
}
