import 'package:fashion_client_app/constants/colors.dart';
import 'package:fashion_client_app/constants/spacing.dart';
import 'package:fashion_client_app/constants/texts.dart';
import 'package:fashion_client_app/controllers/auth_service.dart';
import 'package:fashion_client_app/utils/my_validator.dart';
import 'package:fashion_client_app/views/authentication/widgets/alternative_login_widget.dart';
import 'package:fashion_client_app/views/authentication/widgets/auth_header.dart';
import 'package:fashion_client_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
    final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obsecureText = true;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  largerSpacing,
                  const AuthHeader(
                    title: 'Sign In',
                    subtitle: 'Hi! Welcome back, you’ve been missed',
                  ),
                  largerSpacing,
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Email', style: normalText),
                        const SizedBox(height: 10),
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
                              MyValidator.emailValidator(value),
                        ),
                        largerSpacing,
                        const Text('Password', style: normalText),
                        smallSpacing,
                        TextFormField(
                          obscureText: _obsecureText,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    _obsecureText = !_obsecureText;
                                  },
                                );
                              },
                              icon: Icon(
                                _obsecureText
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                          controller: _passwordController,
                          validator: (value) =>
                              MyValidator.PasswordValidator(value),
                        ),
                      ],
                    ),
                  ),
                  smallSpacing,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot');
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: blueColor),
                      ),
                    ),
                  ),
                  largerSpacing,
                  CustomButton(
                    text: 'Sign In',
                    onPressed: _handleSignIn,
                  ),
                  largerSpacing,
                  const AlternativeLoginWidget(),
                  largerSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account? '),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context,'/signUp');
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(color: blackColor,backgroundColor: whiteColor,),
              ),
            ),
        ],
      ),
    );
  }
  void _handleSignIn() {
    if (formKey.currentState!.validate()) {
      setState(
        () {
          _isLoading = true;
        },
      );

      AuthService()
          .loginWithEmail(_emailController.text, _passwordController.text)
          .then(
        (value) {
          setState(
            () {
              _isLoading = false;
            },
          );

          if (value == "Login Success") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login Successful")),
            );
            Navigator.pushReplacementNamed(context, '/navBar');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(value)),
            );
          }
        },
      ).catchError(
        (error) {
          setState(
            () {
              _isLoading = false;
            },
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $error")),
          );
        },
      );
    }
  }
}