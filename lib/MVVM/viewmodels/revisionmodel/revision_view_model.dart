import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:memo_neet/MVVM/models/revision/revision_list_model.dart';
import 'package:memo_neet/MVVM/models/revision/revision_model.dart';
import 'package:memo_neet/constants/constant.dart';
import 'package:memo_neet/constants/hive_box_name.dart';

class RevisionViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int currentLevel = 0;
  late Box<RevisionListModel> _revisionQuestionBox;
  late Box<int> revisionCompletedQuestionCount;
  Map<int, int> questionsByLevel = {};

  int _completedQuestioCount = 0;
  int get completedQuestionCount => _completedQuestioCount;

  int _pendingQuestioCount = 0;
  int get pendingQuestionCount => _pendingQuestioCount;

  Future<void> getQuestionsCountByLevel(Subject subject) async {
    _isLoading = false;
    revisionCompletedQuestionCount = await Hive.openBox<int>(
        HiveBoxName.revisionCompletedQuestionCountBoxName);
    _completedQuestioCount =
        revisionCompletedQuestionCount.get(subject.toString()) ?? 0;

    _revisionQuestionBox = await Hive.openBox<RevisionListModel>(
        HiveBoxName.revisionQuestionsBoxName);

    List<RevisionModel> revisionQuestions = _revisionQuestionBox
            .get(subject.toString())
            ?.revisionQuestions
            .toList() ??
        [];

    // Get the current time
    DateTime currentTime = DateTime.now();

    // Filter the questions that are before the current time
    List<RevisionModel> filteredQuestions = revisionQuestions
        .where((element) =>
            element.date.isBefore(currentTime) ||
            (element.level == 6 &&
                element.date.isAfter(
                    currentTime))) // Include completed questions that haven't passed 24 hours
        .toList();

    _pendingQuestioCount = filteredQuestions.length;
    notifyListeners();
    for (int level = 0; level <= 6; level++) {
      int questionsCount =
          filteredQuestions.where((element) => element.level == level).length;
      questionsByLevel[level] = questionsCount;
    }
    _isLoading = false;
  }
}
