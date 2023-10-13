import 'package:flutter/material.dart';

class BannerProvider extends ChangeNotifier {
  int _activeIndex = 0;

  int get activeIndex => _activeIndex;

  set activeIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }
}
