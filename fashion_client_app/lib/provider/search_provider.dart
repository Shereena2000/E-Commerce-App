
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
   String searchQuery='';
   void updateSearchQuery(String newQuery) {
    searchQuery = newQuery;
    notifyListeners();
   
  }
}