// ignore_for_file: constant_identifier_names

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/models/Auth/user_model.dart';
import 'package:memo_neet/MVVM/models/questions/question_model.dart';
import 'package:memo_neet/MVVM/models/subjects/chapters/chapter_model.dart';
import 'package:memo_neet/MVVM/models/subjects/chapters/topics/subtopics/subtopic_model.dart';
import 'package:memo_neet/MVVM/models/subjects/chapters/topics/topic_model.dart';
import 'package:memo_neet/MVVM/models/subjects/subject_model.dart';
import 'package:memo_neet/constants/constant.dart';
import 'package:memo_neet/constants/shared_prefs_helper.dart';
import 'package:memo_neet/repo/firebase_database_services.dart';
import 'package:memo_neet/repo/questions_services.dart';
import 'package:memo_neet/repo/subjects_data.dart';
import 'package:memo_neet/repo/user_progress_services.dart';
import 'package:memo_neet/utils/database/sqlite_database.dart';
import '../../../repo/revision_service.dart';

class SubjectViewModel extends ChangeNotifier {
  // Variables for managing state and data
  String selectedMcqAnswer = "";
  String correctMcqAnswer = "";
  String diagramImageUrl = "";
  bool checkResult = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isQuestionLoading = false;
  bool get isQuestionLoading => _isQuestionLoading;
  set isQuestionLoading(bool value) {
    _isQuestionLoading = value;
    notifyListeners();
  }

  bool _isRevison = false;
  bool get isRevision => _isRevison;
  set isRevision(bool v) {
    _isRevison = v;
    notifyListeners();
  }

  int currentRevisionLevel = 0;
  set setCurrentRevisionLevel(int level) {
    currentRevisionLevel = level;
    notifyListeners();
  }

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  UserModel userModel = UserModel();

  Subject _selectedSubject = Subject.biology;
  Subject get selectedSubject => _selectedSubject;

  List<SubjectModel> subjects = [];
  addSubject(SubjectModel value) {
    subjects.add(value);
    notifyListeners();
  }

  SubjectModel? _selectedSubjectModel;
  SubjectModel? get selectedSubjectModel => _selectedSubjectModel;

  List<ChapterModel> chapters = [];
  ChapterModel? _selectedChapterModel;
  ChapterModel? get selectedChapterModel => _selectedChapterModel;

  List<TopicModel> topics = [];
  TopicModel? _selectedTopicModel;
  TopicModel? get selectedTopicModel => _selectedTopicModel;

  List<SubTopicModel> subTopics = [];
  SubTopicModel? _selectedSubTopicModel;
  SubTopicModel? get selectedSubTopicModel => _selectedSubTopicModel;

  // List of questions for UI display
  List<QuestionModel> questions = []; //
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // Selecting and updating subject, chapter, topic, subtopic

  set setSelectedSubject(int index) {
    switch (subjects[index].subjectName) {
      case "Biology":
        _selectedSubject = Subject.biology;
        break;
      case "Physics":
        _selectedSubject = Subject.physics;
        break;
      case "Chemistry":
        _selectedSubject = Subject.chemistry;
        break;
    }
    _selectedSubjectModel = subjects[index];

    updateChaptersProgress();
    notifyListeners();
  }

  setSelectedChapter(int index) async {
    _selectedChapterModel = selectedSubjectModel?.chapters[index];
    topics = _selectedChapterModel?.topics ?? [];
    updateTopics();
    notifyListeners();
  }

  setSelectedTopic(int index) async {
    _selectedTopicModel = topics[index];
    subTopics.clear();
    udpateSubTopics();
    notifyListeners();
  }

  setSelectedSubTopic(int index) async {
    setIsLoading = true;
    _selectedSubTopicModel = subTopics[index];
    questions = _selectedSubTopicModel?.questions ?? [];
    notifyListeners();
    setIsLoading = false;
  }

  // Fetching subject data
  getSubjects() {
    subjects = SubjectsData().getSubjects();
    notifyListeners();
  }

  // Fetching revision questions

  Future getRevisionQuestions() async {
    await RevisionService()
        .fetchRevisionQuestions(selectedSubject, currentRevisionLevel)
        .then((value) {
      questions = value.map((element) => element.questions).toList();
      log("Revision Questions: ${questions.length}");
      notifyListeners();
    });
  }

  void getDiagram(String folderName, String unique) async {
    diagramImageUrl = await FirebaseDatabaseServices().getDiagram(
      folderName,
      unique,
    );
    notifyListeners();
  }

  // Question Loading Functions
  Future loadQuestions() async {
    _isQuestionLoading = true;
    await QuestionsServices().loadQuestionsFromJsonToSql().then((value) async {
      Constant.prefs.setBool(SharedPrefsHelper.questionStored, true);
      _isQuestionLoading = false;
      notifyListeners();
    });
  }

  // Increment Completed question count
  incrementCompletedQuestionCount(String questionId) async {
    await UserProgressServices().incrementCompletedQuestion(
        selectedSubject,
        selectedChapterModel!.chapterName,
        selectedTopicModel!.topicName,
        selectedSubTopicModel!.subTopicName,
        questionId);

    selectedSubTopicModel!.progressCount++;
    topics
        .firstWhere(
            (element) => element.topicName == selectedTopicModel!.topicName)
        .progressCount++;
    notifyListeners();
    selectedSubjectModel!.chapters
        .firstWhere((element) =>
            element.chapterName == selectedChapterModel!.chapterName)
        .progressCount++;
  }

  // Updating topic details
  updateTopics() async {
    for (TopicModel each in topics) {
      if (each.isBookmark) {
        each.numberOfQuestions = await QuestionsServices()
            .getBookMarkedQuestionCount(
                "$selectedSubject >> ${selectedChapterModel!.chapterName}");
      } else {
        each.numberOfQuestions = await QuestionsServices().getQuestionsCount(
          "$selectedSubject >> ${selectedChapterModel!.chapterName} >> ${each.topicName}",
        );
      }
      each.progressCount = await UserProgressServices().getCompletedQuestionCount(
          "$selectedSubject >> ${selectedChapterModel!.chapterName} >> ${each.topicName}");
    }

    notifyListeners();
  }

  // Updating subtopic details
  udpateSubTopics() async {
    if (_selectedTopicModel!.isBookmark) {
      await QuestionsServices()
          .getBookMarkedQuestion(
              "$selectedSubject >> ${selectedChapterModel?.chapterName}")
          .then((value) {
        for (QuestionModel each in value) {
          var subTopicName =
              each.topicName.split(">>").last.trim().replaceAll("  ", " ");
          if (subTopics.every((e) => e.subTopicName != subTopicName)) {
            // fetch correctly answerd question form hive with the topic name key
            subTopics.add(
              SubTopicModel(
                  subTopicName: subTopicName,
                  topicName: each.topicName,
                  questions: [each]),
            );
          } else {
            subTopics
                .firstWhere((element) => element.subTopicName == subTopicName)
                .questions
                .add(each);
          }
        }
      });
    } else {
      await SqliteDatabase()
          .getQuestionsInRange(_selectedSubject, _selectedTopicModel!.uidStart,
              _selectedTopicModel!.uidEnd)
          .then((value) {
        for (QuestionModel each in value) {
          var subTopicName =
              each.topicName.split(">>").last.trim().replaceAll("  ", " ");
          if (subTopics.every((e) => e.subTopicName != subTopicName)) {
            // fetch correctly answerd question form hive with the topic name key
            subTopics.add(
              SubTopicModel(
                  subTopicName: subTopicName,
                  topicName: each.topicName,
                  questions: [each]),
            );
          } else {
            subTopics
                .firstWhere((element) => element.subTopicName == subTopicName)
                .questions
                .add(each);
          }
        }
      });
    }
    for (SubTopicModel each in subTopics) {
      each.progressCount = await UserProgressServices().getCompletedQuestionCount(
          "$selectedSubject >> ${selectedChapterModel!.chapterName} >> ${selectedTopicModel!.topicName} >> ${each.subTopicName}");
    }

    notifyListeners();
  }

  // Updating bookmarked topics
  updateBookmarkTopics() async {
    log("updating bookmark");
    await QuestionsServices()
        .getBookMarkedQuestion(
            "$selectedSubject >> ${selectedChapterModel?.chapterName}")
        .then((value) {
      int bookmarkTopicIndex =
          topics.indexWhere((element) => element.isBookmark);
      topics[bookmarkTopicIndex].numberOfQuestions = value.length;
      // subTopics.clear();

      // for (QuestionModel each in value) {
      //   var subTopicName =
      //       each.topicName.split(">>").last.trim().replaceAll("  ", " ");
      //   if (subTopics.every((e) => e.subTopicName != subTopicName)) {
      //     // fetch correctly answerd question form hive with the topic name key
      //     subTopics.add(
      //       SubTopicModel(
      //           subTopicName: subTopicName,
      //           topicName: each.topicName,
      //           questions: [each]),
      //     );
      //   } else {
      //     subTopics
      //         .firstWhere((element) => element.subTopicName == subTopicName)
      //         .questions
      //         .add(each);
      //   }
      // }
    });
  }

  void updateChaptersProgress() async {
    for (ChapterModel each in _selectedSubjectModel!.chapters) {
      each.numberOfQuestions = await QuestionsServices()
          .getQuestionsCount("$selectedSubject >> ${each.chapterName}");
      each.progressCount = await UserProgressServices()
          .getCompletedQuestionCount("$selectedSubject >> ${each.chapterName}");
    }
    notifyListeners();
  }
}
