import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/controllers/auth_service.dart';
import 'package:fashion_admin_app/views/authentication/widgets/social_button.dart';
import 'package:flutter/material.dart';

class AlternativeLoginWidget extends StatelessWidget {
  final Color colour;
  final Color textColor;
  final bool whiteSocialButton;
  const AlternativeLoginWidget({
    super.key,
    this.colour = blackColor,
    this.textColor = blackColor,
    this.whiteSocialButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: colour,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child:
                  Text('or continue with', style: TextStyle(color: textColor)),
            ),
            Expanded(
              child: Divider(
                color: colour,
              ),
            ),
          ],
        ),
        moderateSpacing,
        SocialButton(
          imagePath: "assets/google_icon.png",
          title: 'Sigin with google',
          onPressed: () {
            print('first');
            handleGoogleSignIn(context);
          },
          useWhiteBackground: whiteSocialButton,
        ),
      ],
    );
  }
  void handleGoogleSignIn(BuildContext context) {
  AuthService().signInWithGoogle().then((value) {
    print('Second');
    print(value);

    if (value == "Google sign-in successful") {
      print('Print 3rd');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Successful")),
      );
      print('Print 4');
      Navigator.pushReplacementNamed(context, '/home');
      print('5');
    } else {
      print('6');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(value)),
      );
      print("7");
    }
  });
}
}
