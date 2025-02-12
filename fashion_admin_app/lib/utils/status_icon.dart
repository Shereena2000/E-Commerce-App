import 'package:flutter/material.dart';

Text statusIcon(String status) {
  if (status == "PAID") {
    return const Text(
      "PAID",
      style: TextStyle(color: Colors.blueAccent, fontSize: 15),
    );
  }
  if (status == "SHIPPED") {
    return const Text(
      "SHIPPED",
      style: TextStyle(color: Colors.orangeAccent, fontSize: 15),
    );
  } else if (status == "DELIVERED") {
    return const  Text(
      "DELIVERED",
      style: TextStyle(color: Colors.green, fontSize: 15),
    );
  } else {
    return const Text(
      "CANCELED",
      style: TextStyle(color: Colors.red, fontSize: 15),
    );
  }
}
