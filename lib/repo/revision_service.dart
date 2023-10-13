// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:memo_neet/MVVM/models/questions/question_model.dart';
import 'package:memo_neet/constants/constant.dart';
import 'package:memo_neet/constants/hive_box_name.dart';

import '../MVVM/models/revision/revision_list_model.dart';
import '../MVVM/models/revision/revision_model.dart';

class RevisionService extends ChangeNotifier {
  late Box<RevisionListModel> _revisionQuestionBox;
  late Box<int> revisionCompletedQuestionCount;
  final int _questionsAddedAfter24Hours = 0;
  int get questionsAddedAfter24Hours => _questionsAddedAfter24Hours;

  bool _isTestMode = false;
  bool get isTestMode => _isTestMode;
  set isTestMode(value) {
    _isTestMode = value;
    notifyListeners();
  }

  Future<void> storeRevisionQuestion(
    String subject,
    QuestionModel question,
  ) async {
    _revisionQuestionBox = await Hive.openBox<RevisionListModel>(
      HiveBoxName.revisionQuestionsBoxName,
    );
    log(_revisionQuestionBox.toString());

    DateTime currentTime = DateTime.now();
    DateTime expiryTime = currentTime.add(
        (_isTestMode) ? const Duration(minutes: 1) : const Duration(days: 1));

    RevisionListModel? subjectQuestions = _revisionQuestionBox.get(subject);

    if (subjectQuestions == null) {
      // No questions stored for the subject
      _revisionQuestionBox.put(
        subject,
        RevisionListModel(
          subject: subject,
          revisionQuestions: [
            RevisionModel(
              questions: question,
              level: 0,
              date: expiryTime,
            )
          ],
        ),
      );
    } else {
      List<RevisionModel> revisionQuestions =
          subjectQuestions.revisionQuestions;
      bool questionExists = revisionQuestions.any(
        (revModel) => revModel.questions.uniqueId == question.uniqueId,
      );

      if (!questionExists) {
        // Only add if the question doesn't exist in the list
        revisionQuestions.add(
          RevisionModel(
            questions: question,
            level: 0,
            date: expiryTime,
          ),
        );
        subjectQuestions.revisionQuestions = revisionQuestions;
        _revisionQuestionBox.put(subject, subjectQuestions);
      }
    }

    // Check if the question is added after 24 hours
    Box<int> questionsAddedAfter24HoursBox =
        await Hive.openBox<int>(HiveBoxName.questionsAddedAfter24HoursBoxName);

    int questionsAddedCount = questionsAddedAfter24HoursBox.get(subject) ?? 0;
    questionsAddedCount++;
    questionsAddedAfter24HoursBox.put(subject, questionsAddedCount);

    notifyListeners();
  }

  // update question time
  Future<void> updateQuestionTime(
      Subject subject, QuestionModel questionModel) async {
    log("updatingQuestionTime");
    _revisionQuestionBox = await Hive.openBox<RevisionListModel>(
        HiveBoxName.revisionQuestionsBoxName);

    String questionId = questionModel.uniqueId;

    RevisionListModel? subjectQuestions =
        _revisionQuestionBox.get(subject.toString());

    if (subjectQuestions == null) {
      // No questions stored for the subject
      return;
    }

    List<RevisionModel> revisionQuestions = subjectQuestions.revisionQuestions;
    int index = revisionQuestions.indexWhere(
        (revisionModel) => revisionModel.questions.uniqueId == questionId);

    if (index != -1) {
      if (revisionQuestions[index].level < 6) {
        revisionQuestions[index].date = DateTime.now().add((_isTestMode)
            ? const Duration(minutes: 1)
            : const Duration(days: 1));

        // Update the entire list in the box
        subjectQuestions.revisionQuestions = revisionQuestions;
        _revisionQuestionBox.put(subject.toString(), subjectQuestions);

        // Save the changes to Hive immediately
        await _revisionQuestionBox.flush();
      } else {
        // Question has reached level 6 (completed)
        revisionCompletedQuestionCount = await Hive.openBox<int>(
            HiveBoxName.revisionCompletedQuestionCountBoxName);

        int completedQuestion =
            revisionCompletedQuestionCount.get(subject.toString()) ?? 0;
        completedQuestion++;
        revisionCompletedQuestionCount.put(
            subject.toString(), completedQuestion);
        log("completed question ${completedQuestion.toString()}");

        // Remove the question from the list
        revisionQuestions.removeAt(index);

        // Update the entire list in the box
        subjectQuestions.revisionQuestions = revisionQuestions;
        _revisionQuestionBox.put(subject.toString(), subjectQuestions);

        // Save the changes to Hive immediately
        await _revisionQuestionBox.flush();
      }
    }
  }

  Future<void> updateQuestionLevel(
      Subject subject, QuestionModel questionModel) async {
    log("updatingQuestionLevel");
    _revisionQuestionBox = await Hive.openBox<RevisionListModel>(
        HiveBoxName.revisionQuestionsBoxName);

    String questionId = questionModel.uniqueId;

    RevisionListModel? subjectQuestions =
        _revisionQuestionBox.get(subject.toString());

    if (subjectQuestions == null) {
      // No questions stored for the subject
      return;
    }

    List<RevisionModel> revisionQuestions = subjectQuestions.revisionQuestions;
    int index = revisionQuestions.indexWhere(
        (revisionModel) => revisionModel.questions.uniqueId == questionId);

    if (index != -1) {
      if (revisionQuestions[index].level < 6) {
        // Update the level of the question
        revisionQuestions[index].level++;
        revisionQuestions[index].date = DateTime.now().add((_isTestMode)
            ? const Duration(minutes: 1)
            : const Duration(days: 1));

        // Update the entire list in the box
        subjectQuestions.revisionQuestions = revisionQuestions;
        _revisionQuestionBox.put(subject.toString(), subjectQuestions);

        // Save the changes to Hive immediately
        await _revisionQuestionBox.flush();
      } else {
        // Question has reached level 6 (completed)
        revisionCompletedQuestionCount = await Hive.openBox<int>(
            HiveBoxName.revisionCompletedQuestionCountBoxName);

        int completedQuestion =
            revisionCompletedQuestionCount.get(subject.toString()) ?? 0;
        completedQuestion++;
        revisionCompletedQuestionCount.put(
            subject.toString(), completedQuestion);
        log("completed question ${completedQuestion.toString()}");

        // Remove the question from the list
        revisionQuestions.removeAt(index);

        // Update the entire list in the box
        subjectQuestions.revisionQuestions = revisionQuestions;
        _revisionQuestionBox.put(subject.toString(), subjectQuestions);

        // Save the changes to Hive immediately
        await _revisionQuestionBox.flush();
      }
    }
  }

  Future<List<RevisionModel>> fetchRevisionQuestions(
      Subject subject, int level) async {
    log("fetchRevisionQuestions: started");
    _revisionQuestionBox = await Hive.openBox<RevisionListModel>(
      HiveBoxName.revisionQuestionsBoxName,
    );

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
            element.level == level && element.date.isBefore(currentTime))
        .toList();

    return filteredQuestions;
  }
}
