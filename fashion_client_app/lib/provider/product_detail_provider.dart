import 'package:flutter/material.dart';

class ProductDetailProvider extends ChangeNotifier {
  String? _selectedSize;
  String? _selectedColor;

  ProductDetailProvider([
    this._selectedSize,
    this._selectedColor,
  ]);
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void setCurrentPage(int index) {
    _currentPage = index;
    notifyListeners();
  }

  String? get selectedSize => _selectedSize;
  String? get selectedColor => _selectedColor;
  void selectSize(String size) {
    _selectedSize = size;
    notifyListeners();
  }

  void selectColor(String color) {
    _selectedColor = color;
    notifyListeners();
  }

  //dispose
  void resetSelections() {
    _selectedSize = null;
    _selectedColor = null;
    notifyListeners();
  }
}
