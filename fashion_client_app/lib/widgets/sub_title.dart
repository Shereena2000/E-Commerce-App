import 'package:flutter/material.dart';

class SubTitle extends StatelessWidget {
  final String title;
  const SubTitle({

    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(title,style: TextStyle(fontSize: 13),);
  }
}