import 'package:fashion_client_app/controllers/auth_service.dart';
import 'package:flutter/material.dart';


class AuthStateProvider extends ChangeNotifier {
  bool _obscureText = true;
  bool _isLoading = false;

  get obsecureText => _obscureText;
  toggleObsecure() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  get isLoading => _isLoading;
  void handleSignUp(BuildContext context, String name, String email,
      String password, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      _isLoading = true;
      print("Signing up with Email: '$email'");
      final result =
          await AuthService().createAccountwithEmail(name, email, password);

      _isLoading = false;
      print(result);
      if (result == "Account is created") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Account created successfully"),
        ));
        Navigator.pushReplacementNamed(context, '/navBar');
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result)));
      }
    }
  }

  void handleSignIn(BuildContext context, String email, String password,
      GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      _isLoading = true;

      AuthService().loginWithEmail(email, password).then(
        (value) {
          _isLoading = false;

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
          _isLoading = false;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $error")),
          );
        },
      );
    }
  }
}
