

import 'package:hive/hive.dart';
import 'package:memo_neet/MVVM/models/questions/question_model.dart';

part 'question_list_model.g.dart';

@HiveType(typeId: 1)
class QuestionListModel extends HiveObject {
  @HiveField(0)
  final List<QuestionModel> questionList;

 
  QuestionListModel({
    required this.questionList,
  });
}
