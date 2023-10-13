import 'package:flutter/material.dart';

class MatchTypeProvider with ChangeNotifier {
  List<String> englishWords = [
    'Apple',
    'Banana',
    'Cat',
    'Dog',
  ];

  List<String?> dropList = []; // Initialize as an empty list
  List<String> remainingWords = [];

  MatchTypeProvider() {
    dropList = List<String?>.filled(
        englishWords.length, null); // Initialize dropList with null values
    remainingWords.addAll(englishWords);
  }
  void addToDropList(int index, String item) {
    dropList[index] = item;
    remainingWords.remove(item);
    notifyListeners();
  }

  void removeFromDropList(int index) {
    String? word = dropList[index];
    if (word != null) {
      dropList[index] = null;
      remainingWords.add(word);
      notifyListeners();
    }
  }
}
