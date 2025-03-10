import 'package:flutter/material.dart';

class FilterStateProvider with ChangeNotifier {
  final Map<String, bool> _tappedStates = {};
  final Map<String, Map<String, bool>> _checklistStates = {};

  List<String> selectedSize = [];
  List<String> selectedColor = [];
  List<String> selectedPriceRange = [];

  // Temporary filter selections
  List<String> tempSelectedSize = [];
  List<String> tempSelectedColor = [];
  List<String> tempSelectedPriceRange = [];

  bool getTappedState(String key) {
    return _tappedStates[key] ?? false;
  }

  void updateTapped(String key) {
    _tappedStates[key] = !(_tappedStates[key] ?? false);
    notifyListeners();
  }

  Map<String, bool>? getChecklist(String key) {
    return _checklistStates[key];
  }

  void updateChecklist(String key, String item, bool value) {
    if (_checklistStates[key] == null) {
      _checklistStates[key] = {};
    }
    _checklistStates[key]![item] = value;

    // Normalize keys to match what's used in FilterItem
    String normalizedKey = key.toLowerCase().replaceAll(" ", "");

    if (normalizedKey == 'size') {
      if (value) {
        if (!tempSelectedSize.contains(item)) tempSelectedSize.add(item);
      } else {
        tempSelectedSize.remove(item);
      }
    } else if (normalizedKey == 'color') {
      if (value) {
        if (!tempSelectedColor.contains(item)) tempSelectedColor.add(item);
      } else {
        tempSelectedColor.remove(item);
      }
    } else if (normalizedKey == 'prizerange') {
      if (value) {
        if (!tempSelectedPriceRange.contains(item))
          tempSelectedPriceRange.add(item);
      } else {
        tempSelectedPriceRange.remove(item);
      }
    }

    notifyListeners();
  }

  void applyFilters() {
    selectedSize = List.from(tempSelectedSize);
    selectedColor = List.from(tempSelectedColor);
    selectedPriceRange = List.from(tempSelectedPriceRange);
    notifyListeners();
  }

  void resetFilters() {
    _tappedStates.clear();
    _checklistStates.clear();
    selectedSize = [];
    selectedColor = [];
    selectedPriceRange = [];
    tempSelectedColor = [];
    tempSelectedColor = [];
    tempSelectedPriceRange = [];
    notifyListeners();
  }
}
