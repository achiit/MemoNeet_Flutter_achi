import 'package:flutter/material.dart';

// navigation view model for controlling the bottom bar
class NavigationViewModel extends ChangeNotifier {
  int _pageIndex = 0;
  int get page => _pageIndex;
  bool _shouldShowBottomNavBar = false;

  bool get shouldShowBottomNavBar => _shouldShowBottomNavBar;

  void showBottomNavBar() {
    _shouldShowBottomNavBar = true;
    notifyListeners();
  }

  changePage(int i) {
    _pageIndex = i;
    notifyListeners();
  }
}
