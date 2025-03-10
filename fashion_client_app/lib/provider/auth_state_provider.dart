import 'package:fashion_client_app/controllers/auth_service.dart';
import 'package:fashion_client_app/provider/address_provider.dart';
import 'package:fashion_client_app/provider/cart_provider.dart';
import 'package:fashion_client_app/provider/user_provider.dart';
import 'package:fashion_client_app/provider/wishlist_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthStateProvider extends ChangeNotifier {
  User? _user;
  bool _obscureText = true;
  bool _isLoading = false;
  User? get user => _user;
  get obsecureText => _obscureText;
  get isLoading => _isLoading;
  AuthStateProvider() {
    _initialize();
  }

  toggleObsecure() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  void _initialize() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  void handleSignUp(BuildContext context, String name, String email,
      String password, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      _isLoading = true;
      notifyListeners();
      print("Signing up with Email: '$email'");
      final result =
          await AuthService().createAccountwithEmail(name, email, password);

      _isLoading = false;
      notifyListeners();
      print(result);
      if (result == "Account is created") {
        Provider.of<UserProvider>(context, listen: false).reloadData();
        Provider.of<CartProvider>(context, listen: false).reloadData();
        Provider.of<AddressProvider>(context, listen: false).reloadData();
        Provider.of<WishlistProvider>(context, listen: false).reloadData();
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

  handleSignIn(BuildContext context, String email, String password,
      GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      _isLoading = true;
      notifyListeners();
      AuthService().loginWithEmail(email, password).then(
        (value) {
          _isLoading = false;
          notifyListeners();
          if (value == "Login Success") {
            Provider.of<UserProvider>(context, listen: false).reloadData();
            Provider.of<CartProvider>(context, listen: false).reloadData();
            Provider.of<AddressProvider>(context, listen: false).reloadData();
            Provider.of<WishlistProvider>(context, listen: false).reloadData();
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
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $error")),
          );
        },
      );
    }
  }

  Future<void> logout() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await FirebaseAuth.instance.signOut();
      await googleSignIn.signOut();
      await resetFirebaseAuth();
      await FirebaseAuth.instance.currentUser?.reload();
      print("Logged out of Firebase and Google");
      _user = null;
      notifyListeners(); // Notify listeners after logout
    } catch (e) {
      print("Error during logout: $e");
    }
  }

  Future<void> resetFirebaseAuth() async {
    await FirebaseAuth.instance.setPersistence(Persistence.NONE);
    await FirebaseAuth.instance.signOut();
  }

  void handleGoogleSignIn(BuildContext context) {
    AuthService().signInWithGoogle().then(
      (value) {
        print(value);

        if (value == "Google sign-in successful") {
          Provider.of<UserProvider>(context, listen: false).reloadData();
          Provider.of<CartProvider>(context, listen: false).reloadData();
          Provider.of<AddressProvider>(context, listen: false).reloadData();
          Provider.of<WishlistProvider>(context, listen: false).reloadData();
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
    );
  }
}
