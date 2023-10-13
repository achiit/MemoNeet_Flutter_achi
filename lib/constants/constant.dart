import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Subject { biology, physics, chemistry }

class Constant {
  static String appVersion = '2.2.4+5';

  static SharedPreferences prefs = prefs;
  static FirebaseOptions firebaseOptions = const FirebaseOptions(
    apiKey: "AIzaSyCGKfhRNIfvf-DQqOEo-thAzEkGZW6vzNY",
    authDomain: "memoneet-5498.firebaseapp.com",
    databaseURL: "https://memoneet-5498.firebaseio.com",
    projectId: "memoneet-5498",
    storageBucket: "memoneet-5498.appspot.com",
    messagingSenderId: "540788350539",
    appId: "1:540788350539:web:d79a54859c3bd1318937ce",
    measurementId: "G-48KVRB0F19",
  );

  static const String privicyPolicyUrl =
      "https://www.memoneet.com/memoneet-privacy-policy";
  static const String termsAndConditionsUrl =
      "https://www.memoneet.com/terms-and-conditions";

  static const String questionsBoxName = 'questions';
  static const String subjectsBoxName = 'subjects';
  static const String revisionQuestionsBoxName = 'revision_question_box';
  static const String revisionCompletedQuestionCountBoxName =
      'revision_completed_question_count';
  static const String questionsAddedAfter24HoursBoxName =
      "questions_added_after_24_hours";

  // static const String temporaryQuestionsKey = 'temporary_questions';
  // static const String correctQuestionsKey = 'shortterm_questions';
  // static const String correctlyDoneBoxName = 'correct_questions';
}

final firebaseAuth = FirebaseAuth.instance;
