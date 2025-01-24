import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/constants/texts.dart';
import 'package:fashion_admin_app/controllers/auth_service.dart';
import 'package:fashion_admin_app/utils/auth_validator.dart';
import 'package:fashion_admin_app/views/authentication/widgets/auth_header.dart';
import 'package:fashion_admin_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: beigeColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Column(
          children: [
            const AuthHeader(
              title: 'Forgot',
              subtitle: 'Please enter your email to reset your password',
            ),
            largerSpacing,
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email',
                    style: normalText,
                  ),
                  smallSpacing,
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (value) => MyValidator.emailValidator(value),
                  ),
                ],
              ),
            ),
            smallSpacing,
            CustomButton(
              text: 'Continue',
              onPressed: () {
                AuthService().resetPassword(emailController.text).then((value) {
                  if (value == "Mail Sent") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Password reset link sent to your email')));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(value)));
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
