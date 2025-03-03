import 'package:flutter/material.dart';

Widget buildSummaryRow(String label, String value, {bool isBold = false,bool isMoney=true}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
      ),
      Text(
      isMoney?  "₹$value":value,
        style: TextStyle(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
      ),
    ],
  );
}