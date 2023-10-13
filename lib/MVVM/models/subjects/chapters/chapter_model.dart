// enum SelectedSubject { biology, physics, chemistry }

import 'package:hive/hive.dart';
import 'package:memo_neet/MVVM/models/subjects/chapters/topics/topic_model.dart';

part 'chapter_model.g.dart';

@HiveType(typeId: 4)
class ChapterModel extends HiveObject {
  @HiveField(0)
  final String chapterName;

  final bool isFreeChapter;

  @HiveField(1)
  final List<TopicModel> topics;

  @HiveField(2)
  int progressCount;

  @HiveField(3)
  int numberOfQuestions;

  ChapterModel({
    required this.chapterName,
    required this.topics,
    this.isFreeChapter = false,
    this.progressCount = 0,
    this.numberOfQuestions = 0,
  });
}
