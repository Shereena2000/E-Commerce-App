import 'package:fashion_admin_app/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:fashion_admin_app/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      backgroundColor: beigeColor,
      title: Text(
        title,
        style:screenText
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
