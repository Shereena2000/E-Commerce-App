import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/widgets/app_bar_logo_title.dart';
import 'package:flutter/material.dart';

class CustomMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomMainAppBar({
    super.key,
    this.height = kToolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: whiteColor,
      title:const AppBarLogoTitle()
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
