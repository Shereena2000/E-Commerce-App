import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int _currentIndex=0;
  int get currentindex=>_currentIndex;
  void updateIndex(int index){
    _currentIndex=index;
    notifyListeners();
  }
}