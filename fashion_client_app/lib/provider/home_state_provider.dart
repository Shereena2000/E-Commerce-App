import 'package:flutter/material.dart';

class HomeStateProvider extends ChangeNotifier {
 int _verticalPageIndex = 0;
get verticalPageIndex=>_verticalPageIndex;
void setVerticalPageIndex(int index){
  _verticalPageIndex=index;
  notifyListeners();
}
}