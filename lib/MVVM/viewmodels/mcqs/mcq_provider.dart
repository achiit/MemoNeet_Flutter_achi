// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:memo_neet/MVVM/models/questions/question_model.dart';
import 'package:memo_neet/constants/constant.dart';

import '../../../repo/questions_services.dart';

class McqProvider with ChangeNotifier {
  // current question index

  int _currentQuestionIndex = 0;
  final int _correctAnswerCount = 0;
  final int _totalAnswerCount = 0;

  int get correctAnswerCount => _correctAnswerCount;
  int get totalAnswerCount => _totalAnswerCount;
  int get currentQuestionIndex => _currentQuestionIndex;
  // for controlling bookmark
  bool _isBookmarked = false;
  bool get isBookmarked => _isBookmarked;
  set isBookmarked(bool v) {
    _isBookmarked = v;
    notifyListeners();
  }

  bool _checkResult = false;
  bool get checkResult => _checkResult;
  set checkResult(bool v) {
    _checkResult = v;
    notifyListeners();
  }

  // question model
  QuestionModel? _questionModel;
  QuestionModel? get questionModel => _questionModel;
  // for match type
  List<String> mcqOptions = [];
  List<String> dragOptions = [];
  // for fillup type
  List<String> dropList = ["", "", "", ""];
  List<String> fillUpList = [];
  // for mcq type
  String _selectedMcqAnswer = "";
  String get selectedMcqAnswer => _selectedMcqAnswer;
  String _correctOption = "";
  String get correctOption => _correctOption;

  List<String> _shuffledOptions = [];

  List<String> get shuffledOptions => _shuffledOptions;

  void setShuffledOptions(List<String> options) {
    _shuffledOptions = options;
    notifyListeners();
  }

  bool get isAnswerCorrect => (_correctOption == _selectedMcqAnswer);

  set setSelectedMcqAnswer(String v) {
    _selectedMcqAnswer = v;
    notifyListeners();
  }

  set setCurrentQuestionIndex(int index) {
    _currentQuestionIndex = index;
    notifyListeners();
    _shuffledOptions.clear(); // Clear shuffled options for the new question
  }

  set setQuestionModel(QuestionModel v) {
    _questionModel = v;
    notifyListeners();
  }

// navigating to next question
  void increaseIndex() {
    _currentQuestionIndex++;
    notifyListeners();
  }

// navigating to previous question
  void decreaseIndex() {
    if (currentQuestionIndex > 0) {
      _currentQuestionIndex--;
    }
    notifyListeners();
  }

// for bookmark icon change
  void toggleBookmark() {
    _isBookmarked = !_isBookmarked;
    notifyListeners();
  }

  Future isQuestionBookmarked(
      Subject subject, String chapterName, QuestionModel question) async {
    _isBookmarked = await QuestionsServices()
        .isQuestionBookmarked(subject, chapterName, question);
  }

// for updating
  void update() {
    notifyListeners();
  }

  void shuffleOptionsIfNeeded(QuestionModel question) {
    List<String> nonEmptyOptions = [
      question.optionA,
      question.optionB,
      question.optionC,
      question.optionD,
    ].where((option) => option.isNotEmpty).toList();

    bool shouldShuffle = true;

    // Keywords that, if found in an option, indicate that shuffling should be skipped
    List<String> keywordsToSkipShuffle = [
      'true',
      'false',
      'all of the above',
      'both a and b',
      'none of the above'
    ];

    for (String option in nonEmptyOptions) {
      if (keywordsToSkipShuffle
          .any((keyword) => option.toLowerCase().contains(keyword))) {
        shouldShuffle = false;
        _shuffledOptions = List.from(nonEmptyOptions);

        break;
      }
    }

    if (nonEmptyOptions.isNotEmpty &&
        _shuffledOptions.isEmpty &&
        shouldShuffle) {
      _shuffledOptions = List.from(nonEmptyOptions);
      _shuffledOptions.shuffle();
    }
  }

// for mcq type
  void checkAnswer(List<QuestionModel> mcqData) {
    final question = mcqData[currentQuestionIndex];
    shuffleOptionsIfNeeded(question);

    if (shuffledOptions[0] == question.answer) {
      _correctOption = "A";
    } else if (shuffledOptions[1] == question.answer) {
      _correctOption = "B";
    } else if (shuffledOptions[2] == question.answer) {
      _correctOption = "C";
    } else {
      _correctOption = "D";
    }
  }
}
