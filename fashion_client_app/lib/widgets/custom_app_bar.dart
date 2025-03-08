import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/constants/texts.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return AppBar(
      
      backgroundColor: whiteColor,
      title: Center(
        child: Text(title, style: appBarText),
      )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
