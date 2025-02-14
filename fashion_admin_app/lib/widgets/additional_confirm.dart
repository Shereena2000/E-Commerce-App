import 'package:fashion_admin_app/constants/colors.dart';
import 'package:flutter/material.dart';

class AdditionalConfirm extends StatelessWidget {
  final String contentText;
  final VoidCallback onYes,onNo;
  const AdditionalConfirm({super.key, required this.contentText, required this.onYes, required this.onNo});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteColor,
      title:const Text("Are you sure"),
      content: Text(contentText),
      actions: [
        TextButton(onPressed: onNo, child:const Text("No")),
        TextButton(onPressed: onYes, child:const Text("Yes")),
      ],
    );
  }
}