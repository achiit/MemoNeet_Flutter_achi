import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:memo_neet/MVVM/models/npcm/crossword_model.dart';
import 'package:memo_neet/MVVM/models/npcm/npcm_model.dart';
import 'package:memo_neet/MVVM/models/questions/question_model.dart';
import 'package:memo_neet/utils/database/sqlite_database.dart';

import '../MVVM/models/npcm/podcast_model.dart';


class NPCMServices {
  Future loadNpcmQuestionsOnSql() async {
    var db = SqliteDatabase();
    final String jsonContent =
        await rootBundle.loadString('jsonFiles/npcm.json');
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
      await db.insertNpcmQuestions(question);
    }
  }

  Future<NPCMModel> getNpcmTopic(NPCMModel npcmModel) async {
    var db = SqliteDatabase();
    List<QuestionModel> npcmQuestions =
        await db.getNpcmQuestionInRange(npcmModel.uidStart, npcmModel.uidEnd);

    for (QuestionModel each in npcmQuestions) {
      switch (each.quizType) {
        case "podcast":
          npcmModel.listOfPodcasts.add(PodcastModel(
            topic: each.topicName.split(">>").last.trim(),
            podcast: each.question,
          ));
          break;
        case "crossword":
          npcmModel.listOfCrosswords.add(CrosswordModel(
            topic: each.topicName.split(">>").last.trim(),
            crossword: each.question,
          ));
          break;
        case "meme":
          npcmModel.memes = each.question;
          break;
        case "notes":
          npcmModel.notes = each.question;
          break;
      }
    }
    return npcmModel;
  }

  Future storenpcmData() async {
    // List<String> uniqueChapters = [];
    // List<NPCMModel> npcmList = [];
    // // Store the NPCM data in the database
    // final String jsonContent =
    //     await rootBundle.loadString('jsonFiles/npcm.json');
    // final List<dynamic> npcmData = await json.decode(jsonContent);

    // for (final npcm in npcmData) {
    //   String topicName = npcm['topic_name'];
    //   String chapterName = topicName.split(' >> ')[0];
    //   String subtopicName = (topicName.split(' >> ').length >= 3)
    //       ? topicName.split(' >> ')[2]
    //       : "";

    //   if (uniqueChapters.contains(chapterName)) {
    //     int index = npcmList.indexWhere((e) {
    //       return e.chapterName == chapterName;
    //     });

    //     switch (npcm['quiz_type']) {
    //       case "podcast":
    //         npcmList[index].listOfPodcasts.add(PodcastModel(
    //               topic: subtopicName,
    //               podcast: npcm['question'],
    //             ));
    //         break;
    //       case "crossword":
    //         npcmList[index].listOfCrosswords.add(CrosswordModel(
    //               topic: subtopicName,
    //               crossword: npcm['question'],
    //             ));
    //         break;
    //       case "meme":
    //         npcmList[index].memes = npcm['question'];
    //         break;
    //       case "notes":
    //         npcmList[index].notes = npcm['question'];
    //         break;
    //     }
    //   } else {
    //     uniqueChapters.add(chapterName);
    //     switch (npcm['quiz_type']) {
    //       case "podcast":
    //         npcmList.add(NPCMModel(listOfPodcasts: [
    //           PodcastModel(
    //             topic: subtopicName,
    //             podcast: npcm['question'],
    //           )
    //         ], listOfCrosswords: [], chapterName: chapterName));
    //         break;
    //       case "crossword":
    //         npcmList.add(NPCMModel(listOfPodcasts: [], listOfCrosswords: [
    //           CrosswordModel(
    //             topic: subtopicName,
    //             crossword: npcm['question'],
    //           )
    //         ], chapterName: chapterName));
    //         break;
    //       case "meme":
    //         npcmList.add(NPCMModel(
    //             listOfPodcasts: [],
    //             listOfCrosswords: [],
    //             chapterName: chapterName,
    //             memes: npcm['question']));
    //         break;
    //       case "notes":
    //         npcmList.add(NPCMModel(
    //             listOfPodcasts: [],
    //             listOfCrosswords: [],
    //             chapterName: chapterName,
    //             notes: npcm['question']));
    //         break;
    //     }
    //   }
    // }
    // npcmList.forEach((element) {
    //   print(element.chapterName);
    // });
  }
}
