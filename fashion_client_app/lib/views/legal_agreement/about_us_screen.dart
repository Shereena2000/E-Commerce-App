import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/constants/texts.dart';
import 'package:fashion_client_app/widgets/custom_main_app_bar.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomMainAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("About Us",style: headlineText,),
             smallSpacing,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Welcome to ",
                      style: normalText,
                    ),
                    TextSpan(
                      text: "Fashoin",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                       
                      ),
                    ),
                    TextSpan(
                      text:
                          " – your ultimate destination for trendy and stylish dresses! At Fashoin, we believe that fashion is a form of self-expression, and we’re here to help you find the perfect outfit that matches your unique style.",
                      style: normalText,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Welcome to Fashoin – your ultimate destination for trendy and stylish dresses! At Fashoin, we believe that fashion is a form of self-expression, and we’re here to help you find the perfect outfit that matches your unique style.",
                style: normalText,
              ),
              SizedBox(height: 10),
              Text(
                "We are passionate about delivering high-quality products, exceptional customer service, and a user-friendly platform that makes shopping enjoyable. Thank you for choosing Fashoin – where fashion meets convenience!",
                style: normalText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
