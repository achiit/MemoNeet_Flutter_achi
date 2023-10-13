import 'package:hive/hive.dart';
import 'package:memo_neet/MVVM/models/subjects/chapters/chapter_model.dart';

part 'subject_model.g.dart';

@HiveType(typeId: 3)
class SubjectModel extends HiveObject {
  @HiveField(0)
  final String imageUrl;

  @HiveField(1)
  final String subjectName;

  @HiveField(2)
  final List<ChapterModel> chapters;

  @HiveField(3)
  int progressCount;

  SubjectModel(
      {required this.imageUrl,
      required this.subjectName,
      required this.chapters,
      this.progressCount = 0});
}
