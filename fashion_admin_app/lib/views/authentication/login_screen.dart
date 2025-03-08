import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/constants/texts.dart';
import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/providers/auth_state_provider.dart';
import 'package:fashion_admin_app/utils/auth_validator.dart';
import 'package:fashion_admin_app/views/authentication/widgets/auth_header.dart';
import 'package:fashion_admin_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final authStateProvider=Provider.of<AuthStateProvider>(context);
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
                          obscureText: authStateProvider.obsecureText,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            suffixIcon: IconButton(
                              onPressed: authStateProvider.toggleObsecureText,
                              icon: Icon(
                               authStateProvider.obsecureText
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
                        style: TextStyle(color: colorTheme),
                      ),
                    ),
                  ),
                  largerSpacing,
                  CustomButton(
                    text: 'Sign In',
                    onPressed: (){_handleSignIn(context);},
                  ),
               //   largerSpacing,
              //    const AlternativeLoginWidget(),
             smallSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account? '),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signUp');
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (authStateProvider.isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(color: colorTheme,backgroundColor: beigeColor,),
              ),
            ),
        ],
      ),
    );
  }

  // void _handleSignIn() {
    void _handleSignIn(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final authStateProvider = Provider.of<AuthStateProvider>(context, listen: false);
      authStateProvider
          .login(_emailController.text, _passwordController.text)
          .then((result) {
        if (result == "Login Success") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login Successful")),
          );
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result)),
          );
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $error")),
        );
      });
    }
  }
}
