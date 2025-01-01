import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/constants/texts.dart';
import 'package:fashion_admin_app/controllers/auth_service.dart';
import 'package:fashion_admin_app/utils/my_validator.dart';
import 'package:fashion_admin_app/views/authentication/widgets/alternative_login_widget.dart';
import 'package:fashion_admin_app/views/authentication/widgets/auth_header.dart';
import 'package:fashion_admin_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              smallSpacing,
              AuthHeader(
                title: 'Create Account',
                subtitle:
                    'Fill your information below or register with your social account',
              ),
              smallSpacing,
              Form(
                key: formKey,
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
                        obscureText: _obsecureText,
                        decoration: InputDecoration(
                          hintText: '..............',
                          hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obsecureText = !_obsecureText;
                              });
                            },
                            icon: Icon(
                              _obsecureText
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
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    AuthService()
                        .createAccountwithEmail(
                            _emailController.text, _passwordController.text)
                        .then((value) {
                      if (value == "Account is created") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Login Successful"),
                        ));
                        Navigator.pushReplacementNamed(context, '/dashboard');
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(value)));
                        print(value);
                      }
                    });
                  }
                },
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
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
