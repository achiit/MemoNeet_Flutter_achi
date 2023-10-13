import 'package:flutter/material.dart';

class FillupTypeProvider extends ChangeNotifier {
  List<String> options = ['Hu', 'man', 'Be', 'ing'];
  String concatenatedOptions = '';

  void addToConcatenatedOptions(String option) {
    if (concatenatedOptions.isEmpty) {
      concatenatedOptions = option;
    } else {
      concatenatedOptions += option;
    }
    options.remove(option);
    notifyListeners();
  }

  void resetOptions() {
    concatenatedOptions = '';
    options = ['Hu', 'man', 'Be', 'ing'];
    notifyListeners();
  }
}
