import 'package:flutter/material.dart';

Widget buildMenuItem(
      {required icon, required String title, required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
            leading: Icon(icon, color: Colors.black),
            title: Text(
              title,
              style: const TextStyle(color: Colors.black),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 15,
            ),
            onTap: onTap),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }