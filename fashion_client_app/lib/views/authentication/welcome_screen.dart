import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/views/authentication/widgets/alternative_login_widget.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/titleImage.jpg'), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 4,
                ),
                CustomButton(
                  text: 'Get Started',
                 
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/signUp'),
                ), Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an accouny?', style: TextStyle(color: whiteColor),),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signin');
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          color: whiteColor,
                          
                          ),
                        ),
                      ),
                    ],
                  ),  greatterSpacing,
                const  AlternativeLoginWidget(colour: whiteColor,textColor: whiteColor,),const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
