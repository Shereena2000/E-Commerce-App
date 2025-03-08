import 'package:fashion_admin_app/constants/Texts.dart';
import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/titleImage.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 4),
                CustomButton(
                  text: 'Get Started',
                  width: MediaQuery.of(context).size.width * 0.8,
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/signUp'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an accouny?', style: smallText),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decorationColor: colorTheme,
                          decoration: TextDecoration.underline,
                          color: colorTheme,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // const AlternativeLoginWidget(
                //   whiteSocialButton: true,
                //   colour: whiteColor,
                //   textColor: whiteColor,
                // ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
