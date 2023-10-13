// ignore_for_file: avoid_print, unused_field

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:memo_neet/MVVM/models/questions/question_list_model.dart';
import 'package:memo_neet/MVVM/models/questions/question_model.dart';
import 'package:memo_neet/MVVM/models/subjects/chapters/chapter_model.dart';
import 'package:memo_neet/MVVM/models/subjects/chapters/topics/topic_model.dart';
import 'package:memo_neet/MVVM/models/subjects/subject_model.dart';
import 'package:memo_neet/constants/constant.dart';
import 'package:memo_neet/constants/hive_box_name.dart';
import 'package:memo_neet/constants/strings.dart';
import 'package:memo_neet/repo/npcm_services.dart';
import 'package:memo_neet/repo/subjects_data.dart';
import 'package:memo_neet/utils/database/sqlite_database.dart';

class QuestionsServices extends ChangeNotifier {
  late Box<QuestionListModel> _questionsBox;
  late Box<SubjectModel> _subjectsBox;
  late Box<int> _questionsCountBox;

  Map<String, int> questionCount = {};

  Future<void> storeQuestionsCount(String key, int questionsCount) async {
    _questionsCountBox = await Hive.openBox<int>(HiveBoxName.questionsCountBox);
    _questionsCountBox.put(key, questionsCount);
  }

  Future<int> getQuestionsCount(String key) async {
    _questionsCountBox = await Hive.openBox<int>(HiveBoxName.questionsCountBox);
    int? questionsCount = _questionsCountBox.get(key);
    return questionsCount ?? 0;
  }

  Future<void> storeQuestions(List<QuestionModel> questions) async {
    // Initialize questionCount map for each topic
    questionCount = {};

    for (var question in questions) {
      final QuestionListModel? existingQuestions =
          _questionsBox.get(question.topicName);
      if (existingQuestions != null) {
        // Update the count of questions for the topic
        questionCount[question.topicName] =
            existingQuestions.questionList.length + 1;

        existingQuestions.questionList.add(question);
        _questionsBox.put(question.topicName, existingQuestions);
      } else {
        // Initialize the count of questions for the topic if it doesn't exist
        questionCount[question.topicName] = 1;

        QuestionListModel questionsList =
            QuestionListModel(questionList: [question]);

        await _questionsBox.put(question.topicName, questionsList);
      }
    }
  }

  Future<List<QuestionModel>> getBookMarkedQuestion(String topicName) async {
    _questionsBox =
        await Hive.openBox<QuestionListModel>(HiveBoxName.questionsBoxName);
    return _questionsBox.get(topicName)?.questionList ?? [];
  }

  Future<int> getBookMarkedQuestionCount(String topicName) async {
    return (await getBookMarkedQuestion(topicName)).length;
  }

  Future loadQuestionsFromJsonToSql() async {
    log("started: loadQuestionsFromJsonToSql");
    var db = SqliteDatabase();
    Map<Subject, String> jsonPaths = {
      Subject.biology: 'jsonFiles/biology.json',
      Subject.chemistry: 'jsonFiles/chemistry.json',
      Subject.physics: 'jsonFiles/physics.json',
    };
    for (var selectedSubject in jsonPaths.keys) {
      final String jsonContent =
          await rootBundle.loadString(jsonPaths[selectedSubject]!);
      final List<dynamic> questionsData = await json.decode(jsonContent);
      for (var questionData in questionsData) {
        QuestionModel question = QuestionModel(
          uniqueId: questionData['unique_id'].toString(),
          question: questionData['question'].toString(),
          answer: questionData['answer'].toString(),
          explanation: questionData['explanation'].toString(),
          topicName: questionData['topic_name'].toString(),
          difficultyLevel: questionData['difficulty_level'].toString(),
          optionA: questionData['option_a'].toString(),
          optionB: questionData['option_b'].toString(),
          optionC: questionData['option_c'].toString(),
          optionD: questionData['option_d'].toString(),
          quizType: questionData['quiz_type'],
        );
        await db.insertQuestion(selectedSubject, question);
      }
    }
    await NPCMServices().loadNpcmQuestionsOnSql();
    await storeQuestionCountsForSubjectsData();
  }

  // store all question count
  Future<void> storeQuestionCountsForSubjectsData() async {
    List<SubjectModel> subjects = SubjectsData().getSubjects();
    Subject currentSubject = Subject.physics;

    for (SubjectModel subject in subjects) {
      int subjectQuestionCount = 0;
      for (ChapterModel chapter in subject.chapters) {
        int chapterQuestionCount = 0;
        for (TopicModel topic in chapter.topics) {
          int topicQuestionCount = 0;

          switch (subject.subjectName) {
            case AppStrings.physics:
              currentSubject = Subject.physics;
              break;
            case AppStrings.chemistry:
              currentSubject = Subject.chemistry;
              break;
            case AppStrings.biology:
              currentSubject = Subject.biology;
              break;
          }
          topicQuestionCount = await SqliteDatabase()
              .getQuestionsCount(currentSubject, topic.uidStart, topic.uidEnd);
          chapterQuestionCount += topicQuestionCount;
          await storeQuestionsCount(
              "$currentSubject >> ${chapter.chapterName} >> ${topic.topicName}",
              topicQuestionCount);
        }
        await storeQuestionsCount(
            "$currentSubject >> ${chapter.chapterName}", chapterQuestionCount);
      }
      await storeQuestionsCount(subject.subjectName, subjectQuestionCount);
    }
  }

  // function defining
  Future<void> toggleBookmark(
      Subject subject, String chapterName, QuestionModel question) async {
    // hive box open
    _questionsBox =
        await Hive.openBox<QuestionListModel>(HiveBoxName.questionsBoxName);

    // final List<String> keySplit = question.topicName.split(" >> ");
    // final String chapterName = keySplit[0];
    // final String subtopicName = (keySplit.length >= 3) ? keySplit[2] : '';

    // SubjectModel subjectModel =
    //     _subjectsBox.get(subject.toString().split('.').last)!;
    String bookmarkKey = '$subject >> $chapterName';

    // // Get the existing bookmarked questions for the topic
    QuestionListModel? bookmarks = _questionsBox.get(bookmarkKey);
    if (bookmarks == null || bookmarks.questionList.isEmpty) {
      _questionsBox.put(
          bookmarkKey, QuestionListModel(questionList: [question]));
      //   ChapterModel bookmarksChapter =
      //       subjectModel.chapters.firstWhere((c) => c.chapterName == chapterName);
      //   bookmarksChapter.topics
      //       .firstWhere((t) => t.topicName == "Bookmarked Questions")
      //       .subTopics
      //       .add(
      //         SubTopicModel(
      //           subTopicName: subtopicName,
      //           topicName: "Bookmarked >> ${question.topicName}",
      //           noOfQuestions: 1,
      //         ),
      //       );
    } else {
      if (bookmarks.questionList.contains(question)) {
        bookmarks.questionList.remove(question);

        //     // Remove bookmark subtopic from the "Bookmarked" topic

        //     ChapterModel bookmarksChapter = subjectModel.chapters
        //         .firstWhere((c) => c.chapterName == chapterName);
        //     TopicModel bookmarksTopic = bookmarksChapter.topics
        //         .firstWhere((t) => t.topicName == "Bookmarked Questions");

        //     bookmarksTopic.subTopics.removeWhere(
        //       (subTopic) => subTopic.topicName == question.topicName,
        //     );
        //     SubTopicModel bookmarksSubtopic = bookmarksTopic.subTopics
        //         .firstWhere((st) => st.subTopicName == subtopicName);
        //     if (bookmarksSubtopic.noOfQuestions <= 1) {
        //       bookmarksTopic.subTopics
        //           .removeWhere((st) => st.subTopicName == subtopicName);
        //     } else {
        //       bookmarksSubtopic.noOfQuestions--;
        //     }
      } else {
        bookmarks.questionList.add(question);

        //     // Add bookmark subtopic to the "Bookmarked" topic
        //     ChapterModel bookmarksChapter = subjectModel.chapters
        //         .firstWhere((c) => c.chapterName == chapterName);
        //     bookmarksChapter.topics
        //         .firstWhere((t) => t.topicName == "Bookmarked Questions")
        //         .subTopics
        //         .firstWhere((st) => st.subTopicName == subtopicName)
        //         .noOfQuestions++;
      }

      log("Bookmarked questions of $bookmarkKey ${bookmarks.questionList.length}");
      _questionsBox.put(bookmarkKey, bookmarks);
    }
    // print(bookmarks!.questionList.toString());
    // _subjectsBox.put(subject.toString().split('.').last, subjectModel);
  }

  Future<bool> isQuestionBookmarked(
      Subject subject, String chapterName, QuestionModel question) async {
    _questionsBox =
        await Hive.openBox<QuestionListModel>(HiveBoxName.questionsBoxName);

    // Get the existing bookmarked questions for the topic
    QuestionListModel? bookmarks =
        _questionsBox.get("$subject >> $chapterName");

    if (bookmarks != null) {
      // Check if the question is bookmarked for the given topic
      return bookmarks.questionList
          .where((element) => element.uniqueId == question.uniqueId)
          .isNotEmpty;
    }
    // If there are no bookmarks for the topic, return false
    return false;
  }

  Future<int> getBookmarkedQuestionCount() async {
    // _questionsBox =
    //     await Hive.openBox<QuestionListModel>(HiveBoxName.questionsBoxName);

    // int totalBookmarkedQuestions = 0;

    // // Iterate through all the bookmark keys and count the bookmarked questions
    // for (String bookmarkKey in _questionsBox.keys) {
    //   QuestionListModel? bookmarks = _questionsBox.get(bookmarkKey);
    //   if (bookmarks != null) {
    //     totalBookmarkedQuestions += bookmarks.questionList.length;
    //   }
    // }

    // return totalBookmarkedQuestions;
    return 0;
  }
}

// Future loadQuestionsFromJson() async {
//   Map<Subject, String> jsonPaths = {
//     Subject.Biology: 'jsonFiles/biology.json',
//     Subject.Chemistry: 'jsonFiles/chemistry.json',
//     Subject.Physics: 'jsonFiles/physics.json',
//   };

//   _questionsBox =
//       await Hive.openBox<QuestionListModel>(HiveBoxName.questionsBoxName);
//   _subjectsBox =
//       await Hive.openBox<SubjectModel>(HiveBoxName.subjectsBoxName);
//   await _questionsBox.clear();
//   await _subjectsBox.clear();

//   for (var selectedSubject in jsonPaths.keys) {
//     List<QuestionModel> questions = [];
//     Set<String> topicKeys = {};
//     final String jsonContent =
//         await rootBundle.loadString(jsonPaths[selectedSubject]!);
//     final List<dynamic> questionsData = await json.decode(jsonContent);
//     for (var questionData in questionsData) {
//       topicKeys.add(questionData['topic_name'].toString());
//       questions.add(
//         QuestionModel(
//           uniqueId: questionData['unique_id'].toString(),
//           question: questionData['question'].toString(),
//           answer: questionData['answer'].toString(),
//           explanation: questionData['explanation'].toString(),
//           topicName: questionData['topic_name'].toString(),
//           difficultyLevel: questionData['difficulty_level'].toString(),
//           optionA: questionData['option_a'].toString(),
//           optionB: questionData['option_b'].toString(),
//           optionC: questionData['option_c'].toString(),
//           optionD: questionData['option_d'].toString(),
//           quizType: questionData['quiz_type'],
//         ),
//       );
//     }
//     await storeQuestions(questions).then((value) async {
//       log("Questions stored successfully");
//       log("questions: ${questions.length}");

//       // After storing questions, call storeSubjectDetail
//       await storeSubjectDetail(topicKeys.toList(), selectedSubject);
//     });
//   }
// }

// Future<List<SubjectModel>> getSubjects() async {
//   _subjectsBox =
//       await Hive.openBox<SubjectModel>(HiveBoxName.subjectsBoxName);
//   return _subjectsBox.values.toList();
// }

// Future<void> storeSubjectDetail(
//     List<String> topicKeys, Subject selectedSubject) async {
//   _subjectsBox = Hive.box<SubjectModel>(HiveBoxName.subjectsBoxName);
//   SubjectModel subject = SubjectModel(
//     subjectName: selectedSubject.toString().split('.').last,
//     chapters: [],
//     imageUrl: '',
//   );

//   Set<String> uniqueChapters = {};

//   for (var key in topicKeys) {
//     if (key.isEmpty) continue;
//     final List<String> keySplit = key.split(" >> ");
//     late String topicName;
//     late String subtopicName;
//     late String chapterName = keySplit[0];
//     if (keySplit.length >= 3) {
//       topicName = keySplit[1];
//       subtopicName = keySplit[2];
//     } else {
//       continue;
//     }

//     // Create chapter if it doesn't exist
//     ChapterModel chapter;
//     if (!uniqueChapters.contains(chapterName)) {
//       chapter = ChapterModel(chapterName: chapterName, topics: [
//         TopicModel(topicName: "Bookmarked Questions", subTopics: [])
//       ]);

//       subject.chapters.add(chapter);
//       uniqueChapters.add(chapterName);
//     } else {
//       chapter =
//           subject.chapters.firstWhere((c) => c.chapterName == chapterName);
//     }

//     // Create topic if it doesn't exist
//     TopicModel topic;
//     if (!chapter.topics.any((t) => t.topicName == topicName)) {
//       topic = TopicModel(topicName: topicName, subTopics: []);
//       chapter.topics.add(topic);
//     } else {
//       topic = chapter.topics.firstWhere((t) => t.topicName == topicName);
//     }

//     // Create subtopic if subtopicName is not empty
//     if (subtopicName.isNotEmpty) {
//       SubTopicModel subtopic = SubTopicModel(
//           subTopicName: subtopicName.toString(),
//           topicName: key.toString(),
//           noOfQuestions: questionCount[key] ?? 0);
//       topic.subTopics.add(subtopic);
//     }
//   }
//   _subjectsBox.put(subject.subjectName, subject);
// }
