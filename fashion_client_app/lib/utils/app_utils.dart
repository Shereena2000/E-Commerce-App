
  import 'package:flutter/material.dart';

final Map<String, Color> colorMap = {
    'Red': Colors.red,
    'Yellow': Colors.yellow,
    'Blue': Colors.blue,
    'White': Colors.white,
    'Black': const Color.fromARGB(255, 58, 57, 57),
  };
    final List<String> categoryTypes = [
    "Women's Western Wear",
    "Women's Ethenic Wear",
    "Men's Wear",
    "Kids Wear",
  ];
  Map<String, bool> productSize = {
    'XS': false,
    'S': false,
    'M': false,
    'L': false,
    'XL': false,
    'XXL': false,
  };
   Map<String, bool> productColor = {
    'Red': false,
    'Yellow': false,
     'Blue': false,
    'White': false,
    'Black': false,
   
  };
 Map<String, bool> productPriceRange = {
  "Below ₹500": false,
  "₹500 - ₹1,000": false,
  "₹1,000 - ₹2,500": false,
  "₹2,500 - ₹5,000": false,
  "₹5,000 - ₹10,000": false,
  "Above ₹10,000": false,
};