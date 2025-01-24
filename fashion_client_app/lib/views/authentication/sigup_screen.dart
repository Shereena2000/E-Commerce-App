import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/constants/texts.dart';

import 'package:fashion_client_app/provider/auth_state_provider.dart';
import 'package:fashion_client_app/utils/my_validator.dart';
import 'package:fashion_client_app/views/authentication/widgets/alternative_login_widget.dart';
import 'package:fashion_client_app/views/authentication/widgets/auth_header.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigupScreen extends StatelessWidget {
  SigupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // bool _obsecureText = true;
  

  @override
  Widget build(BuildContext context) {
    final authStateProvide = Provider.of<AuthStateProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  smallSpacing,
                  const AuthHeader(
                    title: 'Create Account',
                    subtitle:
                        'Fill your information below or register with your social account',
                  ),
                  smallSpacing,
                  Form(
                    key: authStateProvide.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        smallSpacing,
                        const Text(
                          'Email',
                          style: normalText,
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter your email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: (value) =>
                                MyValidator.emailValidator(value)),
                        moderateSpacing,
                        const Text(
                          'Password',
                          style: normalText,
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            controller: _passwordController,
                            validator: (value) =>
                                MyValidator.PasswordValidator(value)),
                        moderateSpacing,
                        const Text(
                          'Confirm Password',
                          style: normalText,
                        ),
                        TextFormField(
                            obscureText: authStateProvide.obsecureText,
                            decoration: InputDecoration(
                              hintText: 'Re-enter Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  authStateProvide.toggleObsecure();
                                },
                                icon: Icon(
                                  authStateProvide.obsecureText
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            controller: _confirmPasswordController,
                            validator: (value) =>
                                MyValidator.repeatPasswordValidator(
                                    value: value,
                                    password: _passwordController.text)),
                      ],
                    ),
                  ),
                  largerSpacing,
                  CustomButton(
                    text: 'Sign Up',
                    onPressed: () => authStateProvide.handleSignUp(
                      context,
                      _emailController.text,
                      _passwordController.text,
                    ),
                  ),
                  largerSpacing,
                  const AlternativeLoginWidget(),
                  largerSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signin');
                        },
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (authStateProvide.isLoading)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: blackColor,
                    backgroundColor: whiteColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
