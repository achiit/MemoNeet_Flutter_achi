import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:memo_neet/constants/constant.dart';
import 'package:memo_neet/constants/hive_box_name.dart';

class UserProgressServices {
  late Box<int> _completedQuestionsCounter;
  late Box<String> _completedQuestionsBox;

  Future<bool> storeCompletedQuestion(String questionId) async {
    _completedQuestionsBox =
        await Hive.openBox<String>(HiveBoxName.completedQuestionBox);
    if (_completedQuestionsBox.values.contains(questionId)) {
      return false;
    } else {
      _completedQuestionsBox.add(questionId);
    }
    return true;
  }

  incrementCompletedQuestion(Subject subject, String chapter, String topic,
      String subTopic, String questionId) async {
    _completedQuestionsCounter =
        await Hive.openBox<int>(HiveBoxName.completedQuestionCounterBox);

    String subjectKey = "$subject";
    String chapterKey = "$subject >> $chapter";
    String topicKey = "$subject >> $chapter >> $topic";
    String subTopicKey = "$subject >> $chapter >> $topic >> $subTopic";

    await storeCompletedQuestion(questionId).then((value) {
      if (value) {
        int? currentcount = _completedQuestionsCounter.get(subjectKey);
        currentcount ??= 0;
        _completedQuestionsCounter.put(subjectKey, currentcount + 1);

        currentcount = _completedQuestionsCounter.get(chapterKey);
        currentcount ??= 0;
        _completedQuestionsCounter.put(chapterKey, currentcount + 1);

        currentcount = _completedQuestionsCounter.get(topicKey);
        currentcount ??= 0;
        _completedQuestionsCounter.put(topicKey, currentcount + 1);

        currentcount = _completedQuestionsCounter.get(subTopicKey);
        currentcount ??= 0;
        _completedQuestionsCounter.put(subTopicKey, currentcount + 1);

        log("incremented completed question count");
      }
    });
  }

  // get completedQuestion
  Future<int> getCompletedQuestionCount(String key) async {
    _completedQuestionsCounter =
        await Hive.openBox<int>(HiveBoxName.completedQuestionCounterBox);
    int? currentcount = _completedQuestionsCounter.get(key);
    return currentcount ?? 0;
  }
}
