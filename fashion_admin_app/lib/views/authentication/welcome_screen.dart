
import 'package:fashion_admin_app/constants/Texts.dart';
import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        double buttonWidth = isMobile
            ? MediaQuery.of(context).size.width * 0.8
            : 300; // Fixed width for web

        return Container(
          decoration:  BoxDecoration(
            image: DecorationImage(
              image: AssetImage(isMobile? 'assets/mbile_title_enhanced.jpg':'assets/desktop_title_enhanced.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 40),
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
                      width: buttonWidth,
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/signUp'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?', style: smallText),
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
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
