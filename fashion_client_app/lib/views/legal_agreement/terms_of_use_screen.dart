import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/constants/texts.dart';
import 'package:fashion_client_app/widgets/custom_main_app_bar.dart';
import 'package:flutter/material.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomMainAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                "Terms of Use",
                style: headlineText,
              ),
              smallSpacing,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Welcome to",style: normalText),
                    TextSpan(text: " Fashoin!",style: TextStyle(
                          fontWeight: FontWeight.bold,
                         ),),
                    TextSpan(
                      text:
                          " By using our app, you agree to comply with and be bound by the following terms and conditions. Please read them carefully.\n\n",
                      style: normalText,
                    ),
                    TextSpan(
                      text: "1. Eligibility\n",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                         ),
                    ),
                    TextSpan(
                      text:
                          "You must be at least 13 years old to use this app.\nBy using Fashoin, you confirm that you have the legal capacity to enter into this agreement.\n\n",
                      style: normalText,
                    ),
                    TextSpan(
                      text: "2. Account Registration\n",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                         ),
                    ),
                    TextSpan(
                      text:
                          "You are responsible for maintaining the confidentiality of your account credentials.\nYou agree to provide accurate and complete information during registration.\n\n",
                      style: normalText,
                    ),
                    TextSpan(
                      text: "3. Purchases\n",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                         ),
                    ),
                    TextSpan(
                      text:
                          "All purchases are subject to availability and pricing at the time of order.\nWe reserve the right to cancel or refuse any order at our discretion.\n\n",
                      style: normalText,
                    ),
                  
                    TextSpan(
                      text: "4. Prohibited Activities\n",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                       ),
                    ),
                    TextSpan(
                      text:
                          "You may not use the app for any illegal or unauthorized purposes.\nYou may not attempt to gain unauthorized access to our systems or interfere with the app’s functionality.\n\n",
                      style: normalText,
                    ),
                    TextSpan(
                      text: "5. Limitation of Liability\n",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                    TextSpan(
                      text:
                          "Fashoin is not liable for any indirect, incidental, or consequential damages arising from your use of the app.\n\n",
                      style: normalText,
                    ),
                    
                    TextSpan(
                      text: "6. Changes to Terms\n",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextSpan(
                      text:
                          "We may update these Terms of Use from time to time. Continued use of the app constitutes acceptance of the revised terms.\n\n",
                      style: normalText,
                    ),
                    
                  ],
                ),
              ),
              liteSpacing
            ],
          ),
        ),
      ),
    );
  }
}
