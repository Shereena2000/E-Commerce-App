import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/providers/auth_state_provider.dart';
import 'package:fashion_admin_app/utils/auth_validator.dart';
import 'package:fashion_admin_app/views/authentication/widgets/auth_header.dart';
import 'package:fashion_admin_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _handleSignUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final authStateProvider =
          Provider.of<AuthStateProvider>(context, listen: false);
      authStateProvider
          .signup(_nameController.text,_emailController.text, _passwordController.text)
          .then((result) {
        if (result == "Account is created") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Account created successfully"),
          ));
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(result)));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authStateProvider = Provider.of<AuthStateProvider>(context);
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
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        smallSpacing,
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                            hintText: 'Enter your name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          controller: _nameController,
                          validator: (value) =>
                              MyValidator.displayNameValidator(value),
                        ),
                       moderateSpacing,
                        TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Email',
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
                        
                        TextFormField(
                            decoration: InputDecoration(
                                 labelText: 'Password',
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
                      
                        TextFormField(
                          obscureText: authStateProvider.obsecureText,
                          decoration: InputDecoration(   labelText: 'Password',
                            hintText: 'Re-enter Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                authStateProvider.toggleObsecureText();
                              },
                              icon: Icon(
                                authStateProvider.obsecureText
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
                                  password: _passwordController.text),
                        ),
                      ],
                    ),
                  ),
                  largerSpacing,
                  CustomButton(
                    text: 'Sign Up',
                    onPressed: () {
                      _handleSignUp(context);
                    },
                  ),
                  // largerSpacing,
                  // const AlternativeLoginWidget(),
            smallSpacing,
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
            if (authStateProvider.isLoading)
              Container(
                color: Colors.black54,
                child:const Center(
                  child: CircularProgressIndicator(
                    color: colorTheme,
                    backgroundColor: beigeColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
