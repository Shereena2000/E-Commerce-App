import 'package:fashion_admin_app/constants/colors.dart';
import 'package:fashion_admin_app/constants/spacing.dart';
import 'package:fashion_admin_app/constants/texts.dart';
import 'package:fashion_admin_app/providers/auth_state_provider.dart';
import 'package:fashion_admin_app/utils/auth_validator.dart';
import 'package:fashion_admin_app/views/authentication/widgets/alternative_login_widget.dart';
import 'package:fashion_admin_app/views/authentication/widgets/auth_header.dart';
import 'package:fashion_admin_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});

  final formKey = GlobalKey<FormState>();

 final TextEditingController _emailController = TextEditingController();

 final TextEditingController _passwordController = TextEditingController();

final  TextEditingController _confirmPasswordController = TextEditingController();

  
  void _handleSignUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
     final authStateProvider = Provider.of<AuthStateProvider>(context, listen: false);
     authStateProvider.signup(_emailController.text, _passwordController.text).then((result){

     

      if (result == "Account is created") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Account created successfully"),
        ));
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
      }
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authStateProvider=Provider.of<AuthStateProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  smallSpacing,
                const  AuthHeader(
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
                            validator: (value) => MyValidator.emailValidator(value)),
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
                            obscureText: authStateProvider.obsecureText,
                            decoration: InputDecoration(
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
                                    password: _passwordController.text)),
                      ],
                    ),
                  ),
                  largerSpacing,
                  CustomButton(
                    text: 'Sign Up',
                    onPressed: (){_handleSignUp(context);},
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
            if (authStateProvider.isLoading)
              Container(
                color: Colors.black54,
                child: Center(
                  child: CircularProgressIndicator(color: colorTheme,backgroundColor: beigeColor,),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
