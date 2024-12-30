import 'package:fashion_admin_app/constants/texts.dart';
import 'package:fashion_admin_app/controllers/auth_service.dart';
import 'package:fashion_admin_app/views/authentication/widgets/alternative_login_widget.dart';
import 'package:fashion_admin_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Create Account',
                style: headlineText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Fill your information below or register with your social account',
                textAlign: TextAlign.center,
                style: extraSmallText,
              ),
              const SizedBox(height: 40),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: normalText,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      controller: _emailController,
                      validator: (value) =>
                          value!.isEmpty ? "Email cannot be empty." : null,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Password',
                      style: normalText,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      controller: _passwordController,
                      validator: (value) => value!.length < 8
                          ? "Password should have at least 8 characters."
                          : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
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
              const SizedBox(height: 30),
              const AlternativeLoginWidget(),
              const SizedBox(height: 20),
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
