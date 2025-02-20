import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/views/profile/widgets/user_alert_dialog.dart';
import 'package:flutter/material.dart';

class UserNameWidget extends StatelessWidget {
  final String name;
  final String email;
  const UserNameWidget({
    super.key, required this.name, required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          largerWidthSpacing,
          Text("Hello $name!"),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return UserAlertDialog(
                       name: name,
                       email: email,
                      );
                    });
              },
              icon: Image.asset("assets/edit_icon.png"))
        ],
      ),
    );
  }
}
