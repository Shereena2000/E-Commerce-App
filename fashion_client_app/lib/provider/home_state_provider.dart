import 'package:flutter/foundation.dart';

class HomeStateProvider extends ChangeNotifier {
  int _verticalPageIndex = 0; // Tracks the current category index
  int _horizontalPageIndex = 0; // Tracks the current promo index within the category

  int get verticalPageIndex => _verticalPageIndex;
  int get horizontalPageIndex => _horizontalPageIndex;

  void setVerticalPageIndex(int index) {
    _verticalPageIndex = index;
    _horizontalPageIndex = 0; // Reset horizontal index when switching categories
    notifyListeners();
  }

  void setHorizontalPageIndex(int index) {
    _horizontalPageIndex = index;
    notifyListeners();
  }
}