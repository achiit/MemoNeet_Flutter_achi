import 'package:hive_flutter/hive_flutter.dart';
import 'package:memo_neet/MVVM/models/questions/question_list_model.dart';
import 'package:memo_neet/MVVM/models/questions/question_model.dart';
import 'package:memo_neet/MVVM/models/revision/revision_list_model.dart';
import 'package:memo_neet/MVVM/models/revision/revision_model.dart';
import 'package:memo_neet/MVVM/models/subjects/chapters/chapter_model.dart';
import 'package:memo_neet/MVVM/models/subjects/subject_model.dart';

Future<void> initializeDb() async {
  await Hive.initFlutter();
  Hive.registerAdapter(QuestionModelAdapter());
  Hive.registerAdapter(QuestionListModelAdapter());
  Hive.registerAdapter(SubjectModelAdapter());
  Hive.registerAdapter(ChapterModelAdapter());
  Hive.registerAdapter(RevisionModelAdapter());
  Hive.registerAdapter(RevisionListModelAdapter());
}
